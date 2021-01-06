output "dns" {
    value = aws_instance.database.public_dns
}