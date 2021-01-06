resource "local_file" "ansible_inventory" {
  content              = <<EOF
[database]
${aws_instance.database.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
EOF
  filename             = "./../ansible/inventories/database_hosts"
  file_permission      = 644
  directory_permission = 644
}