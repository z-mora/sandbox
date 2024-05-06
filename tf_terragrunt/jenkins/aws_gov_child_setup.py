import argparse
import os
from pathlib import Path

import boto3
import hcl2
from botocore.exceptions import ClientError

parser = argparse.ArgumentParser(
    description="""This script should be ran from a GovCloud child Terragrunt module
    (aka working dir) that is also managing the account (which means it should contain
    aws_account.tfvars). This script will join the AWS GovCloud child account to the
    organization specified in aws_account.tfvars, deletes the extra CloudTrail in
    us-gov-west-1, and moves the account to the OU specified in the same .tfvars file."""
)
parser.add_argument(
    "govcloud_account_id",
    help="The AWS GovCloud child account ID to be set up",
    type=str,
)
parser.add_argument(
    "-p",
    "--profile",
    type=str,
    help="The optional boto3 profile name to use",
    default=None,
)
args = parser.parse_args()
gc_account_id = args.govcloud_account_id
username = os.getenv("USER_SHORT", "jenkins")

if not ("child" in str(Path.cwd()) and (Path.cwd() / "aws_account.tfvars").exists()):
    raise ValueError(
        "This script must be ran from a GovCloud child Terragrunt module containing aws_account.tfvars"
    )

print(f"Performing setup for GovCloud account {gc_account_id}...")

print("Locating common_child.tfvars...")
common_child_tfvars_path = None
for parent in Path.cwd().parents:
    if (parent / "common_child.tfvars").exists():
        common_child_tfvars_path = parent / "common_child.tfvars"
        print(f"Found: {common_child_tfvars_path}")
        break
if common_child_tfvars_path is None:
    raise ValueError("Unable to locate common_child.tfvars")

print("Reading variables from common_child.tfvars...")
with common_child_tfvars_path.open() as file:
    common_vars = hcl2.load(file)
    gov_org_role = common_vars["management_account_role"]
    print(f"gov_org_role: {gov_org_role}")
    gov_root_ou = common_vars["root_ou"]
    print(f"gov_root_ou: {gov_root_ou}")

# By default, all sessions & clients will use the Jenkins service account creds which
# are stored in environment variables
print("Assuming roles and setting up sessions...")

# The default session is the current user logged in without assuming any roles
default_session = boto3.Session(region_name="us-gov-east-1", profile_name=args.profile)
default_sts = default_session.client("sts")
default_identity = default_sts.get_caller_identity()
print(f"Default user ARN: {default_identity['Arn']}")

org_master_assumed_role = default_sts.assume_role(
    RoleArn=gov_org_role,
    RoleSessionName=f"terraform-{username}",
    DurationSeconds=900,
)
org_mgmt_creds = org_master_assumed_role["Credentials"]
# This session & the clients it creates are assuming _sys_terragrunt_admin_role
# in the GovCloud org management account
org_mgmt_session = boto3.Session(
    aws_access_key_id=org_mgmt_creds["AccessKeyId"],
    aws_secret_access_key=org_mgmt_creds["SecretAccessKey"],
    aws_session_token=org_mgmt_creds["SessionToken"],
    region_name="us-gov-east-1",
)

organizations_client = org_mgmt_session.client("organizations")
try:
    describe_account_response = organizations_client.describe_account(
        AccountId=gc_account_id
    )
except organizations_client.exceptions.AccountNotFoundException:
    pass  # Account wasn't added to the org yet, continue
else:
    print("AWS GovChild setup completed previously, quitting")
    quit(0)

org_mgmt_sts = org_mgmt_session.client("sts")

account_assumed_role = org_mgmt_sts.assume_role(
    RoleArn=f"arn:aws-us-gov:iam::{gc_account_id}:role/OrganizationAccountAccessRole",
    RoleSessionName=f"terraform-{username}",
    DurationSeconds=900,
)
account_creds = account_assumed_role["Credentials"]
# This session & the clients it creates are assuming OrganizationAccountAccessRole
# in the child GovCloud account
account_session = boto3.Session(
    aws_access_key_id=account_creds["AccessKeyId"],
    aws_secret_access_key=account_creds["SecretAccessKey"],
    aws_session_token=account_creds["SessionToken"],
    region_name="us-gov-east-1",
)


try:
    print(f"Adding GovCloud account {gc_account_id} to the GovCloud org...")
    print("Sending invite from the org master")
    handshake_id = organizations_client.invite_account_to_organization(
        Target={"Id": gc_account_id, "Type": "ACCOUNT"}
    )["Handshake"]["Id"]

    print(f"Accepting handshake ID {handshake_id} from the GovCloud account")
    organizations_account = account_session.client("organizations")
    response = organizations_account.accept_handshake(HandshakeId=handshake_id)
except organizations_client.exceptions.HandshakeConstraintViolationException as e:
    if "account is already a member" in str(e):
        print("GovCloud account is already a member of the org")
    else:
        raise

print("Looking for extra CloudTrail in us-gov-west-1 to delete...")
cloudtrail = account_session.client("cloudtrail", region_name="us-gov-west-1")
trails = cloudtrail.describe_trails()["trailList"]
trail_to_delete = None
for trail in trails:
    if trail["IsMultiRegionTrail"] is False and trail["IsOrganizationTrail"] is False:
        trail_to_delete = trail["Name"]
if trail_to_delete:
    print(f"Deleting extra CloudTrail {trail_to_delete} in us-gov-west-1")
    response = cloudtrail.delete_trail(Name=trail_to_delete)
else:
    print("Extra CloudTrail already deleted from us-gov-west-1")

print("Moving account OU...")
print("Pulling parent_ou_id from aws_account.tfvars")
with open("aws_account.tfvars") as file:
    aws_account_vars = hcl2.load(file)
    ou_id = aws_account_vars["account_details"]["parent_ou_id"]
try:
    print(f"Moving account to OU {ou_id}")
    response = organizations_client.move_account(
        AccountId=gc_account_id,
        SourceParentId=gov_root_ou,
        DestinationParentId=ou_id,
    )
except organizations_client.exceptions.AccountNotFoundException as e:
    print("Account was already moved")
