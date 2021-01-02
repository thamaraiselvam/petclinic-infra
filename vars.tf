variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "zone" {
  type    = string
  default = "ap-south-1a"
}

variable "tags" {
  type = map(any)
  default = {
    name = "petclinic"
  }
}

variable "amis" {
  type = map(any)
  default = {
    "ap-south-1" = "ami-005634d2b7691f303"
  }
}

variable "server_instances" {
  type    = number
  default = 1
}

variable "public_key" {
  type    = string
  default = "mykey.pub"
}