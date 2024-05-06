resource "aws_ssm_maintenance_window" "patching" {
  for_each = local.days

  allow_unassociated_targets = false
  cutoff                     = 1 # min:1 max:2
  description                = "Maintenance window for patch group ${each.key}"
  duration                   = 3 # min:1 max:4
  name                       = "patch_group_window_${each.key}"
  schedule                   = "cron(0 8 ? * ${each.key} *)"
  schedule_timezone          = "UTC"
  tags                       = local.tags
}

resource "aws_ssm_maintenance_window_target" "patching" {
  for_each = local.days

  window_id     = aws_ssm_maintenance_window.patching[each.key].id
  name          = "patch_group_target_${each.key}"
  description   = "Maintenance window target for patch group ${each.key}"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:ssm_patch_group"
    values = [each.key]
  }
}

resource "aws_ssm_maintenance_window_task" "patching" {
  for_each = local.days

  name            = "patch_group_task_${each.key}"
  window_id       = aws_ssm_maintenance_window.patching[each.key].id
  task_type       = "RUN_COMMAND"
  task_arn        = "AWS-RunPatchBaseline"
  max_errors      = "25%"
  max_concurrency = "50%"

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.patching[each.key].id]
  }

  task_invocation_parameters {
    run_command_parameters {
      timeout_seconds = 600

      parameter {
        name   = "Operation"
        values = ["Install"]
      }
      parameter {
        name   = "RebootOption"
        values = ["RebootIfNeeded"]
      }
    }
  }
}
