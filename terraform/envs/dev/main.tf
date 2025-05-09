data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    bucket = "soop-terraform-states"
    key    = "soop/shared/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

/*resource "aws_security_group" "app" {
  vpc_id = data.terraform_remote_state.shared.outputs.vpc_id
  ...
}*/