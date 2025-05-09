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

/*resource "aws_autoscaling_group" "ecs-asg" {
    name = "soop-ecs-asg"
    max_size = 5
    min_size = 0
    health_check_grace_period = 0
    health_check_type = "EC2"
    desired_capacity = 0
    launch_configuration =

    tag {
        key = "AmazonECSManaged"
        value = true
        propagate_at_launch = true
    }
}*/