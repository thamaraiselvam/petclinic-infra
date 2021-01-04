resource "aws_instance" "frontend_service" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend_service.id]
  count                  = var.frontend_service_instances
  key_name               = aws_key_pair.mykey.id

  tags = merge(var.tags, var.frontend_service_tags)
}

resource "null_resource" "deploy_frontend" {
  provisioner "ansible" {
    plays{
      playbook{
        file_path = "${path.cwd}/ansible/frontend_service.yaml"
      }

      extra_vars = {
        frontend_service_version = var.frontend_service_version
        setup_frontend_service = true
        backend_service_addr = "${aws_instance.backend_service.0.public_ip}:9966"
      }

      verbose = true
      inventory_file = local_file.ansible_inventory.filename
    }
  }
}

resource "aws_security_group" "frontend_service" {
  name        = "frontend_service_allow_traffic"
  description = "Allow inbound and outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow 80 port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = var.tags
}
