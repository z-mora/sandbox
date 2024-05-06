app_registrations = {
  _sys_platform_terragrunt_admin = {
    secrets = {
      jenkins = {
        auto_rotate_days = 30
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "terraform_platform/azure/comm/_sys_platform_terragrunt_admin"
        }
      }
    }
  }
}
