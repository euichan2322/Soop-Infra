module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.1.0.0/16"
  project    = "soop"
  env        = "shared"
}

module "ecs" {
  source = "../../modules/ecs"
  project = "soop"
  env = "shared"
}

module "ec2" {
  source = "../../modules/ec2"
  project = "soop"
  env = "shared"
}