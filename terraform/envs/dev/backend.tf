terraform {
  backend "s3" {
    bucket         = "soop-terraform-state-bucket"
    key            = "soop/dev/terraform.tfstate"  # ← dev 경로
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "soop-terraform-locks"
  }
}
