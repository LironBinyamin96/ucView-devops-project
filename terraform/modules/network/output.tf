output "vpc_id" {
  value = data.aws_vpc.liron_vpc.id
}

output "public_subnet_id" {
  value = data.aws_subnet.liron_public_subnet.id
}

output "private_subnet_id" {
  value = data.aws_subnet.liron_private_subnet.id
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}
