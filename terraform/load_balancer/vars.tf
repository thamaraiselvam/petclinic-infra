variable "subnets" {
  type = list(any)
}

variable "listen_port" {
  type    = number
  default = 80
}

variable "target_port" {
  type    = number
  default = 80
}

variable "security_group_id" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

variable "target_one_id" {
  type = string
}

variable "target_two_id" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "alb_target_name" {
  type = string
}