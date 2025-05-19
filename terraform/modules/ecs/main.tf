resource "aws_ecs_cluster" "ecs-cluster" {
    name = "${var.project}-cluster"
    
    tags = {
        Name = "${var.project}-cluster"
        project = var.project
        env = var.env
    }
}

resource "aws_launch_template" "ecs-asg-launch-template" {
    name = "${var.project}-ecs-asg-launch-template"
    instance_type = "t3.medium"
    iam_instance_profile {
      arn = "arn:aws:iam::650553045794:instance-profile/ecsInstanceRole"
    }
    image_id = "ami-0d3c70bbb60c7b255"
    user_data = filebase64("${path.module}/asg.userdata.sh")
    update_default_version = true
}

resource "aws_autoscaling_group" "ecs-asg" {
    name = "${var.project}-ecs-asg"
    vpc_zone_identifier = var.vpc_zone_identifier
    max_size = 3
    min_size = 0
    health_check_grace_period = 0
    health_check_type = "EC2"
    desired_capacity = 0
    launch_template {
      id = aws_launch_template.ecs-asg-launch-template.id
      version = "$Latest"
    }

    tag {
        key = "AmazonECSManaged"
        value = ""
        propagate_at_launch = true
    }
    tag {
        key = "Name"
        value = "ECS Instance - ${var.project}-cluster"
        propagate_at_launch = true
    }
}

/*resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.ecs-asg.name
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 100.0
  }
}*/

resource "aws_ecs_capacity_provider" "cp" {
  name = "${var.project}-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs-asg.arn
    managed_draining = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 3
      minimum_scaling_step_size = 1
      status = "ENABLED"
      target_capacity = 100
      instance_warmup_period = 300
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster-cp" {
  cluster_name = aws_ecs_cluster.ecs-cluster.name

  capacity_providers = [aws_ecs_capacity_provider.cp.name]

  default_capacity_provider_strategy {
    base = 1
    weight = 100
    capacity_provider = aws_ecs_capacity_provider.cp.name
  }
}