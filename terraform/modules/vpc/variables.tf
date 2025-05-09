variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "project" {
  type        = string
  default     = "soop"
}

variable "env" {
  type        = string
  default     = "shared"
}
