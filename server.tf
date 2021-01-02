resource "aws_instance" "server" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
  count                  = var.server_instances
  key_name               = aws_key_pair.mykey.id
}

resource "local_file" "ansible_inventory" {
  content  = <<EOF
[server]
%{for ip in aws_instance.server.*.public_ip~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
%{endfor~}
EOF
  filename = "${path.cwd}/ansible/hosts"
}
