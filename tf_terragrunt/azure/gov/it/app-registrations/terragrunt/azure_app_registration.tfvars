app_registrations = {
  _sys_terragrunt_admin = {
    api_permissions = {
      "Microsoft Graph" = [
        "Application.ReadWrite.All",
        "Directory.Read.All",
      ]
    }
    secrets = {
      jenkins = {
        auto_rotate_days = 30
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "team_cloud/azure/gov/_sys_terragrunt_admin"
        }
      }
    }
  }
}
