resource "local_file" "ansible_inventory" {
  content              = <<EOF
[backend_service]
${aws_instance.backend_service_one.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
${aws_instance.backend_service_two.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
EOF
  filename             = "./../ansible/inventories/backend_hosts"
  file_permission      = 644
  directory_permission = 644
}