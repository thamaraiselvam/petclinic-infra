output "database_dns" {
  value = module.database.dns
}

output "backend_dns" {
  value = module.backend.backend_load_balancer_dns
}

output "frontend_dns" {
  value = module.frontend.frontend_load_balancer_dns
}