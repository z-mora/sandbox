

resource "aws_ssm_maintenance_window" "window" {
  name     = "maintenance-window"
  schedule = "cron(0 16 ? * TUE *)"
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = aws_ssm_maintenance_window.window.id
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:ResourceTypeFilters"
    values = ["AWS::EC2::Instance"]
  }
}

resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency = 2
  max_errors      = 1
  priority        = 1
  task_arn        = "AWS-RestartEC2Instance"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.example.id

  targets {
    key    = "InstanceIds"
    values = [aws_instance.example.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = [aws_instance.example.id]
      }
    }
  }
}
