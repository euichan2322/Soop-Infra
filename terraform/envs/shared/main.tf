module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.1.0.0/16"
  project    = "soop"
  env        = "shared"
}

module "ecs" {
  source = "../../modules/ecs"
  vpc_zone_identifier = module.vpc.private_subnet_ids
  project = "soop"
  env = "shared"
}

module "sg" {
  for_each = local.security_groups

  source  = "../../modules/ec2/sg"
  name    = each.value.name
  vpc_id  = module.vpc.vpc_id

  ingress_rules = each.value.ingress
  egress_rules  = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    role = each.key
    env  = "shared"
  }
}

module "alb" {
  source  = "../../modules/ec2/alb/alb"

  vpc_id = module.vpc.vpc_id
  name = "${var.project}-alb1"
  security_groups = [module.sg["alb"].security_group_id]
  subnets = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]

}