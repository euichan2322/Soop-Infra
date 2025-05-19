data "aws_route53_zone" "main" {
    name = var.domain
}

/*data "aws_acm_certificate" "acm" {
    provider = aws.ap-northesat-2
    domain = "*.${domain}"
}*/