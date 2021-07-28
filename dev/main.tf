provider "aws" {
  region = var.aws-region
}

module "my_vpc" {
  source         = "../modules/vpc"
  vpc-cidr       = var.vpc-cidr
  vpc-id         = module.my_vpc.vpc_id
  dev-pub-sub-01 = var.dev-pub-sub-01
}

module "my_ec2" {
  source        = "../modules/ec2"
  ami_id        = var.ami-id
  instance_type = var.intance-type
  subnet_id     = module.my_vpc.subnet_id
}

module "dynamodb" {
  source = "../modules/db"



}