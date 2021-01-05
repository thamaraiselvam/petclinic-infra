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

variable "service_version" {
  type    = string
  default = "2.2.5"
}

variable "instances_count" {
  type    = number
  default = 1
}

variable "service_port" {
  type    = number
  default = 9966
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