output "public_ips" {
  value = [
    aws_instance.backend_service_one.public_ip,
    aws_instance.backend_service_two.public_ip
  ]
}

output "backend_load_balancer_dns" {
  value = module.elb.dns_name
}