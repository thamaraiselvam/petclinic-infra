variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "tags" {
  type = map(any)
  default = {
    name = "petclinic"
    type = "frontend_service"
  }
}

variable "amis" {
  type = map(any)
  default = {
    "ap-south-1" = "ami-005634d2b7691f303"
  }
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "key_name" {
  type = string
}

variable "backend_service_addr" {
  type = string
}

variable "subnets" {
  type = list(any)
}