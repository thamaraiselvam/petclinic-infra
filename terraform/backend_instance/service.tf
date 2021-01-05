resource "aws_instance" "backend_service_one" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend_service.id]
  key_name               = var.key_name
  subnet_id              = var.subnets.0
  tags                   = var.tags
}

## Remove this after implemented autoscaling
resource "aws_instance" "backend_service_two" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend_service.id]
  key_name               = var.key_name
  subnet_id              = var.subnets.1
  tags                   = var.tags
}


resource "aws_security_group" "backend_service" {
  name        = "backend_service_allow_traffic"
  description = "Allow inbound and outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow service port"
    from_port   = var.service_port
    to_port     = var.service_port
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

resource "null_resource" "deploy_backend" {
  provisioner "ansible" {
    plays {
      playbook {
        file_path = "./../ansible/backend/backend_service.yaml"
      }

      extra_vars = {
        service_version = var.service_version
      }

      verbose        = true
      inventory_file = local_file.ansible_inventory.filename
    }
  }
}

module "elb" {
  source            = "./../load_balancer"
  alb_name          = "backend-alb"
  alb_target_name   = "backend-target"
  subnets           = var.subnets
  security_group_id = [aws_security_group.backend_service.id]
  vpc_id            = var.vpc_id
  target_one_id     = aws_instance.backend_service_one.id
  target_two_id     = aws_instance.backend_service_two.id
  listen_port       = var.service_port
  target_port       = var.service_port
}
