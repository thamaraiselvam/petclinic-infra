output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}