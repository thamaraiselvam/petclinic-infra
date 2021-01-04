output "public_ips" {
  value = [
    aws_instance.frontend_service_one.public_ip,
    aws_instance.frontend_service_two.public_ip
  ]
}

output "frontend_load_balancer_dns" {
  value = module.elb.dns_name
}