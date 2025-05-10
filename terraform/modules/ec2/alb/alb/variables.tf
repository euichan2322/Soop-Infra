variable "project" {
  type        = string
  default     = "soop"
}

variable "env" {
  type        = string
  default     = "shared"
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type = string
  default = "80"
}

variable "security_groups" {
  type = list(string)
  default = []
}

variable "subnets" {
  type = list(string)
  default = []  
}