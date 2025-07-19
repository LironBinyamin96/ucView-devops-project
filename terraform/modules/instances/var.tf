variable "ami_id" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_sg_id" {
  type = string
}

variable "private_sg_id" {
  type = string
}

variable "volume_size" {
  default = 15
}

variable "volume_type" {
  type = string
  default = "gp2"
}

