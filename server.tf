resource "aws_instance" "server" {
  ami           = lookup(var.amis, var.region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
  count         = var.server_instances
  key_name      = aws_key_pair.mykey.id
}