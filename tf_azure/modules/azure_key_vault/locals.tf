locals {
  comm_admin_principals = toset([
    "0652ef60-f369-4dd0-ac3d-13f639d3baf8", # AZ_COMM_CORP_ADMIN
    "2396c137-c80c-4655-90ff-f5881ade9e34", # _sys_terragrunt_admin
    "4f29b03f-58a8-49ba-b180-dd30f17abb7b"  # AZ_COMM_CORP_ALZ
  ])
  gov_admin_principals = toset([
    "0a7bf271-d99b-4edc-9853-6c8e899c62ee", # AZ_GOV_CORP_ADMIN
    "8e53f898-6b1f-4d49-a0ac-1fd4100ccd63", # _sys_terragrunt_admin
  ])
}
