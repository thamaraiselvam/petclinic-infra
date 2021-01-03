output "backend_service_ips" {
  value = aws_instance.backend_service.*.public_ip
}