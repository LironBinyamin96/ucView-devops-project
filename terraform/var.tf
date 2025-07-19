terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }

  required_version = ">= 1.3.0"
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "publicEC2-key"
}

 variable "public_key_path" {
   description = "Path to the public key file"
   type        = string
 }

