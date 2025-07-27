resource "aws_key_pair" "liron-key" {
  key_name   = "var.key_name"
  public_key = file("/var/lib/jenkins/.ssh/publicEC2-key.pub")
}

resource "aws_instance" "public" { # יצירת מכונה ציבורית
  ami                         = var.ami_id
  instance_type               = "t3.medium"
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.public_sg_id]
  key_name                    = aws_key_pair.liron-key.key_name


  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "public-liron"
    AutoShutdown  = "true" 
  }
}

resource "aws_instance" "private" { # יצירת מכונה פרטית
  ami                         = var.ami_id
  instance_type               = "t3.medium"
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.private_sg_id]
  key_name                    = aws_key_pair.liron-key.key_name


   root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "private-liron"
    AutoShutdown  = "true"
  }
}
output "public_ip" {
  description = "The public IP address of the public instance"
  value = aws_instance.public.public_ip
}

output "private_ip_public_instance" {
  description = "The private IP address of the public instance"
  value       = aws_instance.public.private_ip
}


output "private_ip" {
  description = "The private IP address of the private instance"
  value = aws_instance.private.private_ip
}
