# Region #
region = "us-east-1"

# AWS credentials and profile #
aws_creds_file = "%USERPROFILE%/.aws/credentials"
aws_profile = "batel"

# Instances key name #
key_name = "OpsSchool"

# Availability zone #
availability_zone = ["us-east-1a", "us-east-1b"]

# Which type of instance #
instance_type = "t2.micro"

# Number of instances to be created #
instance_count = "2"

# cidr-bloc value for vpc #
vpc_cidr = "10.0.0.0/16"

# cidr-block values for public and private subnets #
private_cidr = ["10.0.10.0/24", "10.0.11.0/24"]
public_cidr = ["10.0.100.0/24", "10.0.101.0/24"]