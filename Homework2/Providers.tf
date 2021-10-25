# Provider #
provider "aws" {
	shared_credentials_file = var.aws_creds_file
	profile = var.aws_profile
	region  = var.region
}
