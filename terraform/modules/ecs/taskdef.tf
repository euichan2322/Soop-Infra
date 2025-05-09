resource "aws_ecs_task_definition" "front-td" {
  family = "${var.project}-front-td"
  requires_compatibilities = [ "EC2", "FARGATE" ]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  execution_role_arn = "arn:aws:iam::650553045794:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "application"
      image     = "650553045794.dkr.ecr.ap-northeast-2.amazonaws.com/soop/front:latest"
      cpu       = 256
      memory    = 512
      memoryReservation = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol = "tcp"
          appProtocol = "http"
          name = "next_port"
        }
      ]
    }
  ])

  tags = {
    Name = "${var.project}-front-td"
    project = var.project
    env = var.env
  }
}