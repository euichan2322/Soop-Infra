variable "project" {
  type        = string
  default     = "soop"
}

variable "env" {
  type        = string
  default     = "shared"
}

variable "subnet_ids" {
  type = list(string)
  default = [""]
}

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "List of subnet IDs for ECS Auto Scaling Group"
}
