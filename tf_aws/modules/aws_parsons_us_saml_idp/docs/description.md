# aws_parsons_us_saml_idp

This module performs the setup required to allow parsons.us users to access an AWS
account via login.parsons.us. This will work in either a Commerical or GovCloud account.
It's intended to be deployed in the same Terragrunt module as the account deployment.

For more info about this setup, see
[AWS SAML setup for .us users](https://confluence.parsons.com/display/IT/AWS+SAML+setup+for+.us+users)

There is an output that provides you with the name(s) of the Okta group(s) you will need
to create and add the users to.
