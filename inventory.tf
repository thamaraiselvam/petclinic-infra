resource "local_file" "ansible_inventory" {
  content  = <<EOF
[backend_service]
%{for ip in aws_instance.backend_service.*.public_ip~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(path.cwd)}/mykey
%{endfor~}
EOF
  filename = "${path.cwd}/ansible/hosts"
  file_permission = 0644
  directory_permission = 0644
}