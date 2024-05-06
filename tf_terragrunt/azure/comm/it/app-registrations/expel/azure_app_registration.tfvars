app_registrations = {
  _sys_expel_mdr = {
    api_permissions = {
      "Log Analytics API" = ["Data.Read"]
      "Microsoft Graph"   = ["User.Read", "SecurityEvents.Read.All"]
    }
    secrets = {
      "Expel-Workbench" = {
        end_date_relative = "4320h"
      }
    }
  }
}
