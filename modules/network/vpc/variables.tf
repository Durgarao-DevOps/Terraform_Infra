variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_app_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_database_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "additional_private_subnet_tags" {
  type    = map(string)
  default = {}
}
