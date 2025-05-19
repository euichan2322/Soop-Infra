variable "project" {
    type = string
    default = "soop"
}

variable "env" {
    type = string
    default = "shared"
}

variable "security_groups" {
    type = list(string)
    default = []
}

variable "domain" {
    type = string
    default = "euichan.com"
}

variable "aws_route53_zone" {
    type = string
    default = "soop.euichan.com"
}