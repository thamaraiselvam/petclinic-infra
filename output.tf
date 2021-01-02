output "server_instance_ips" {
  value = aws_instance.server.*.public_ip
}