data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket = "soop-terraform-state-bucket"
    key    = "soop/shared/terraform.tfstate"
    region = "ap-northeast-2"
  }
}



module "tg" {
  for_each = local.tg
  
  source  = "../../modules/ec2/alb/tg"
  name = each.value.name
  vpc_id = data.terraform_remote_state.shared.outputs.vpc_id
}