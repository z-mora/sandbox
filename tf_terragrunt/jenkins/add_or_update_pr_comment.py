import argparse

from atlassian import Bitbucket
from requests.exceptions import HTTPError

parser = argparse.ArgumentParser(
    description="""Adds or updates a comment on a PR. If a comment is found by the
    author that contains the given title, that comment will be updated. If there's no
    match then a new comment will be added."""
)
# Required positional args
parser.add_argument(
    "project_key",
    type=str,
    help="The Bitbucket project key (can be found in the Bitbucket URL)",
)
parser.add_argument(
    "repo_slug",
    type=str,
    help="The Bitbucket repository slug (can be found in the Bitbucket URL)",
)
parser.add_argument(
    "pr_id",
    type=str,
    help="The Bitbucket pull request ID (can be found in the Bitbucket URL)",
)
parser.add_argument(
    "title",
    type=str,
    help="The comment title, used to find an existing comment to update.",
)
parser.add_argument("text", type=str, help="The comment text.")
parser.add_argument(
    "backup_text",
    type=str,
    help="Backup comment text to send, in case text is too long.",
)
# Optional flags
parser.add_argument(
    "-a",
    "--author",
    type=str,
    default="jenkins",
    help="""Full or partial display name of the comment author. Used to find an existing
      comment to update. If you're using a token you will need to create one under
      your account and not the repo for it to show your display name.""",
)
parser.add_argument(
    "-p", "--password", type=str, help="Bitbucket password. Don't use with token."
)
parser.add_argument(
    "--token", type=str, help="HTTP access token. Don't use with username/password."
)
parser.add_argument(
    "-u", "--username", type=str, help="Bitbucket username. Don't use with token."
)
args = parser.parse_args()

if args.token and (args.username or args.password):
    raise ValueError("Do not use token with username/password")
elif args.token is None and args.username is None and args.password is None:
    raise ValueError("Must specify token or username/password")
elif args.token is None and (args.username is None or args.password is None):
    raise ValueError("Must specify both username and password")

base_url = "https://bitbucket.parsons.com"
bitbucket = Bitbucket(
    url=base_url,
    username=args.username,
    password=args.password,
    token=args.token,
)

try:
    are_we_authenticated = bitbucket.check_inbox_pull_requests_count()
except HTTPError as e:
    if "401" in str(e):
        raise HTTPError("Authentication to Bitbucket API failed")
    else:
        raise

comment_exists = False
comment_id = None
comment_version = None
# Encode and decode string from shell to fix issues with new line characters
backup_text = bytes(args.backup_text, "utf-8").decode("unicode_escape")
text = bytes(args.text, "utf-8").decode("unicode_escape")

activities = bitbucket.get_pull_requests_activities(
    project_key=args.project_key,
    repository_slug=args.repo_slug,
    pull_request_id=args.pr_id,
)
for activity in activities:
    if (
        activity["action"] == "COMMENTED"
        and args.author in activity["comment"]["author"]["displayName"]
        and f"{args.title}\n\n" in activity["comment"]["text"]
    ):
        comment_exists = True
        comment_id = activity["comment"]["id"]
        comment_version = activity["comment"]["version"]

if comment_id is None:
    print(f"Attempting to add new comment...")
    try:
        response = bitbucket.add_pull_request_comment(
            project_key=args.project_key,
            repository_slug=args.repo_slug,
            pull_request_id=args.pr_id,
            text=text,
        )
    except HTTPError as e:
        if "Please enter a non-empty value less than 32768 characters" in str(e):
            print(f"Attempting to add new comment with backup text...")
            response = bitbucket.add_pull_request_comment(
                project_key=args.project_key,
                repository_slug=args.repo_slug,
                pull_request_id=args.pr_id,
                text=backup_text,
            )
        else:
            raise

    comment_id = response["id"]
else:
    print(f"Attempting to update comment {comment_id}...")
    try:
        response = bitbucket.update_pull_request_comment(
            project_key=args.project_key,
            repository_slug=args.repo_slug,
            pull_request_id=args.pr_id,
            comment_id=comment_id,
            comment=text,
            comment_version=comment_version,
        )
    except HTTPError as e:
        if "Please enter a non-empty value less than 32768 characters" in str(e):
            print(f"Attempting to update comment {comment_id} with backup text...")
            response = bitbucket.update_pull_request_comment(
                project_key=args.project_key,
                repository_slug=args.repo_slug,
                pull_request_id=args.pr_id,
                comment_id=comment_id,
                comment=backup_text,
                comment_version=comment_version,
            )
        else:
            raise

print(
    f"{'Updated' if comment_exists else 'Added'} comment:\n"
    f"{base_url}/projects/{args.project_key}/repos/{args.repo_slug}"
    f"/pull-requests/{args.pr_id}/overview?commentId={comment_id}"
)
