resource "aws_instance" "database" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.database.id]
  key_name               = var.key_name
  subnet_id              = var.subnets.0
  tags                   = var.tags
}


resource "aws_security_group" "database" {
  name        = "database_allow_traffic"
  description = "Allow inbound and outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow service port"
    from_port   = var.port
    to_port     = var.port
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

resource "null_resource" "setup_database" {
  provisioner "ansible" {
    plays {
      playbook {
        file_path = "./../ansible/database/setup.yaml"
      }

      extra_vars = {
        user_name     = var.user_name
        database      = var.database
        user_password = var.user_password
      }

      verbose        = true
      inventory_file = local_file.ansible_inventory.filename
    }
  }
}
