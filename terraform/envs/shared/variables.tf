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