resource "aws_instance" "backend_service" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.backend_service.id]
  count                  = var.backend_service_instances
  key_name               = aws_key_pair.mykey.id

  tags = merge(var.tags, var.backend_service_tags)
}

resource "null_resource" "deploy_backend" {
  provisioner "ansible" {
    plays{
      playbook{
        file_path = "${path.cwd}/ansible/backend_service.yaml"
      }

      extra_vars = {
        backend_service_version = var.backend_service_version
        setup_backend_service = true
      }

      verbose = true
      inventory_file = local_file.ansible_inventory.filename
    }
  }
}


resource "aws_security_group" "backend_service" {
  name        = "backend_service_allow_traffic"
  description = "Allow inbound and outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow 9966 port"
    from_port   = 9966
    to_port     = 9966
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
