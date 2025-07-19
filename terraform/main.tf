provider "aws" {
  region = "eu-central-1" #הגדרת האיזור 
}

module "network" {
  source = "./modules/network" # קריאה למודול שמגדיר את התשתית של הרשת - VPC, Subnets, Security Groups, route Tables
}

module "instances" {  # קריאה למודול שמגדיר את ה-EC2 Instances
  source = "./modules/instances" # מייצר את 2 המכונות - ציבורית ופרטית. 
  ami_id = var.ami_id 
  public_key_path = var.public_key_path
  key_name = var.key_name
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  public_sg_id = module.network.public_sg_id
  private_sg_id = module.network.private_sg_id
}

module "ansible-inventory" {
  source = "./modules/ansible-inventory"
  public_ip = module.instances.public_ip
  private_ip = module.instances.private_ip
  private_ip_public_instance = module.instances.private_ip_public_instance
}

output "public_ip" {
  value = module.instances.public_ip
}

output "private_ip" {
  value = module.instances.private_ip
}

output "private_ip_public_instance" { 
  value       = module.instances.private_ip_public_instance
  description = "The private IP address of the public instance."
}