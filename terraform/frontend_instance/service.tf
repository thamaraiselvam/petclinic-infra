resource "aws_instance" "frontend_service_one" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.small"
  vpc_security_group_ids = [aws_security_group.frontend_service.id]
  key_name               = var.key_name
  subnet_id              = var.subnets.0
  tags                   = var.tags
}

resource "aws_instance" "frontend_service_two" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.small"
  vpc_security_group_ids = [aws_security_group.frontend_service.id]
  key_name               = var.key_name
  subnet_id              = var.subnets.1
  tags                   = var.tags
}

resource "null_resource" "setup_frontend" {
  provisioner "ansible" {
    plays {
      playbook {
        file_path = "./../ansible/frontend/service.yaml"
      }

      extra_vars = {
        backend_service_addr = var.backend_service_addr
      }

      verbose        = true
      inventory_file = local_file.ansible_inventory.filename
    }
  }
}

resource "aws_security_group" "frontend_service" {
  name        = "frontend_service_allow_traffic"
  description = "Allow inbound and outbound traffic"
  vpc_id      = var.vpc_id

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

module "elb" {
  source            = "./../load_balancer"
  alb_name          = "frontend-alb"
  alb_target_name   = "frontend-target"
  subnets           = var.subnets
  security_group_id = [aws_security_group.frontend_service.id]
  vpc_id            = var.vpc_id
  target_one_id     = aws_instance.frontend_service_one.id
  target_two_id     = aws_instance.frontend_service_two.id
}
