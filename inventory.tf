# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = <<EOF
[web_servers]
${aws_instance.my_instance.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=terra-key-ec2
EOF
  filename = "${path.module}/inventory.ini"
}
