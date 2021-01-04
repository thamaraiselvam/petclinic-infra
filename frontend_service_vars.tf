variable "frontend_service_version" {
  type = string
  default = "2.5.5"
}

variable "frontend_service_instances" {
  type    = number
  default = 1
}

variable "frontend_service_tags" {
  type = map
  default = {
      type = "frontend_service"
  }
}