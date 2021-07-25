provider "aws" {
  region = "us-east-2"
}

module "my_vpc" {
  source         = "../modules/vpc"
  vpc-cidr       = "10.0.0.0/16"
  tenancy        = "default"
  vpc-id         = module.my_vpc.vpc_id
  dev-pub-sub-01 = "10.0.1.0/24"
}

module "my_ec2" {
  source        = "../modules/ec2"
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = module.my_vpc.subnet_id
}

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "my-table"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
module "my_alb" {
  source  = "../modules/vpc/"
  name    = var.alb_name
  alb     = var.alb
  vpc-id  = module.my_vpc.vpc_id
  dev_public_subnets = var.dev_public_subnets

}
*/
