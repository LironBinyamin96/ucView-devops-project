resource "local_file" "dynamic_inventory" {
  filename = "${path.module}/../../../ansible/inventory.ini"
  content  = <<EOT
[public]
public-ec2 ansible_host=${var.private_ip_public_instance} ansible_user=ubuntu

[private]
private-ec2 ansible_host=${var.private_ip} ansible_user=ubuntu
EOT
}