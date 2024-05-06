default_tags = {
  App         = "ParPro"
  Environment = "PROD"
  GBU         = "INF"
  ITSM        = "MANAGEMENT"
  # This will get set to "" on the account by tf_aws until FinOps can determine the right value
  JobWbs = "897720-01101"
  Owner  = "timothy.stokes@parsons.com"
}
deploy_parsons_us_saml_idp = ["full-admin"]
region                     = "us-east-1"
