resource "aws_ecr_repository" "front-repository" {
  name = "${var.project}/front"
  
  tags = {
    Name = "${var.project}/front"
    project = var.project
    env = var.env
  }
}
resource "aws_ecr_repository" "backend-repository" {
  name = "${var.project}/back"
  
  tags = {
    Name = "${var.project}/back"
    project = var.project
    env = var.env
  }
}
resource "aws_ecr_repository" "app-repository" {
  name = "soop/app"
  
  tags = {
    Name = "${var.project}/app"
    project = var.project
    env = var.env
  }
}