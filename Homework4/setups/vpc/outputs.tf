# outputs for module
output "vpc_id" {
    value = module.test_VPC.vpc_id
}
output "vpc_cidr" {
    value = module.test_VPC.vpc_cidr
}
output "public_subnets" {
    value = "${module.test_VPC.public_subnets}"
}
output "private_subnets" {
    value = "${module.test_VPC.private_subnets}"
}