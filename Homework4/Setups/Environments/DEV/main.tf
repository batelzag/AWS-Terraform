provider "aws" {
	profile = "batel"
	region  = "us-east-1"
	default_tags {
		tags = {
			Enviroment = var.enviroment_tag
			Owner = var.owner_tag
			Project = var.project_tag
		}
	}
}
terraform {
	required_version = ">= 0.12"
  	backend "remote" {
		hostname = "app.terraform.io"
		organization = "Batel-OpsSchool"
		workspaces {
			name = "Homework4"
		}
	}
}
module "vpc" {
	source = "../../../Modules/Web-Server/VPC" 
}
module "web-instances" {
    source = "../../../modules/web-Server/web"
	vpc_id = module.vpc.vpc_id
	public_subnets = "${module.vpc.public_subnets[*]}"
}
module "db-instances" {
	source = "../../../modules/web-Server/db"
	vpc_id = module.vpc.vpc_id
	vpc_cidr = module.vpc.vpc_cidr
	private_subnets = "${module.vpc.private_subnets[*]}"
}