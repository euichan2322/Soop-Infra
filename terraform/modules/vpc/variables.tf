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

variable "region_number" {
  default = {
    ap-northeast = 1
  }  
}

variable "az_number" {
  default = {
    a = 1
    b = 2
  }
}