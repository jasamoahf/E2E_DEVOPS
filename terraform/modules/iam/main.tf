# ECS task execution role (pull image from ECR, write logs)
data "aws_iam_policy_document" "ecs_task_exec_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.name}-ecs-task-exec"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_exec_ecr" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task role (for app runtime AWS access – keep minimal)
data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ecs_task" {
  name               = "${var.name}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
  tags               = var.tags
}
