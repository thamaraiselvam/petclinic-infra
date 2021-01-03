variable "backend_service_version" {
  type = string
  default = "2.5.5"
}

variable "backend_service_instances" {
  type    = number
  default = 1
}

variable "backend_service_tags" {
  type = map
  default = {
      type = "backend_service"
  }
}