app_registrations = {
  _sys_inet_secureframe = {
    api_permissions = {
      "Microsoft Graph" = ["User.Read"]
    }
    secrets = {
      secret_one = {
        end_date_relative = "4320h" # 180 days
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "team_cloud/azure/comm/inet/_sys_inet_secureframe"
        }
      }
    }
  }
}
