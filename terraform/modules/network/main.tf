data "aws_vpc" "liron_vpc" {
  filter {
    name   = "tag:Name"
    values = ["liron-vpc"]
  }
}

data "aws_subnet" "liron_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["liron-public-subnet"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.liron_vpc.id]
  }
}

data "aws_security_group" "liron_jenkins_sg_data" {
  name    = "liron-jenkins-sg"
  vpc_id  = data.aws_vpc.liron_vpc.id
}

data "aws_subnet" "liron_private_subnet" {
  filter {
    name   = "tag:Name"
    values = ["liron-private-subnet"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.liron_vpc.id]
  }
}

resource "aws_security_group" "public_sg" {
  name   = "public-sg-liron"
  vpc_id = data.aws_vpc.liron_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.liron_jenkins_sg_data.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 28080
    to_port     = 28080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-ec2-sg-liron"
  }
}

resource "aws_security_group" "private_sg" {
  name   = "private-sg-liron"
  vpc_id = data.aws_vpc.liron_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-ec2-sg-liron"
  }
}
