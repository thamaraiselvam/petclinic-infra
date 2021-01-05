resource "local_file" "ansible_inventory" {
  content              = <<EOF
[frontend_service]
${aws_instance.frontend_service_one.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
${aws_instance.frontend_service_two.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
EOF
  filename             = "${path.cwd}/ansible/inventories/frontend_hosts"
  file_permission      = 0644
  directory_permission = 0644
}