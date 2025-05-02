terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "soop/prod/terraform.tfstate"  # ← prod 경로
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "my-terraform-locks"
  }
}
