resource "aws_instance" "backend_service" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
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