variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "tags" {
  type = map(any)
  default = {
    name = "petclinic"
    type = "backend_service"
  }
}

variable "amis" {
  type = map(any)
  default = {
    "ap-south-1" = "ami-005634d2b7691f303"
  }
}

variable "port" {
  type    = number
  default = 5432
}

variable "vpc_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnets" {
  type = list(any)
}

variable "user_password" {
  type = string
  default = "password"
}

variable "user_name" {
  type = string
  default = "petclinic"
}

variable "database" {
  type = string
  default = "petclinic"
}