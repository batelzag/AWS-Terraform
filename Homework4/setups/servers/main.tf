# module "test_VPC" {
# 	source = "app.terraform.io/Batel-OpsSchool/test/aws//modules/VPC"
#   	version = "1.0.0"
# }
data "terraform_remote_state" "test_VPC" {
	backend = "remote"
	config = {
		organization = "Batel-OpsSchool"
		workspaces = {
      		name = "Network"
		}
    }
}
module "test_WEB" {
  	source  = "app.terraform.io/Batel-OpsSchool/test/aws//modules/WEB"
  	version = "1.0.0"
  	vpc_id = data.terraform_remote_state.test_VPC.outputs.vpc_id
	public_subnets = "${data.terraform_remote_state.test_VPC.outputs.public_subnets[*]}"
}
module "test_DB" {
  	source  = "app.terraform.io/Batel-OpsSchool/test/aws//modules/DB"
  	version = "1.0.0"	
	vpc_id = data.terraform_remote_state.test_VPC.outputs.vpc_id
	vpc_cidr = data.terraform_remote_state.test_VPC.outputs.vpc_cidr
	private_subnets = "${data.terraform_remote_state.test_VPC.outputs.private_subnets[*]}"
}