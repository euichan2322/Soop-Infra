resource "aws_ecr_repository" "soop-front-repository" {
  name = "soop/front"
  
  tags = {
    Name = "soop/front"
    project = "soop"
    env = "shared"
  }
}
resource "aws_ecr_repository" "soop-backend-repository" {
  name = "soop/back"
  
  tags = {
    Name = "soop/back"
    project = "soop"
    env = "shared"
  }
}
resource "aws_ecr_repository" "soop-app" {
  name = "soop/app"
  
  tags = {
    Name = "soop/app"
    project = "soop"
    env = "shared"
  }
}