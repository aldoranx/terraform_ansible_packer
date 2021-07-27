#aws_vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  

  tags = {
    Name = "dev-vpc"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev_igw"
  }

}

#aws_public_subnets_01
resource "aws_subnet" "dev-public-subnet-01" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.dev-pub-sub-01
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2c"

  tags = {
    Name = "dev-public-subnet-01"
  }
}

#aws_public_subnets_02
resource "aws_subnet" "dev-public-subnet-02" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.dev-pub-sub-02
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "dev-public-subnet-02"
  }
}


#aws_dev_web_server
resource "aws_subnet" "dev-webserver-subnet" {
  vpc_id     = var.vpc-id
  cidr_block = var.dev-webserver-name


  tags = {
    Name = "dev-webserver-subnet"
  }
}


