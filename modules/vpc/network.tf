#aws_vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = "dev-vpc"
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



#aws_webserver_sg
resource "aws_security_group" "dev-webserver-sg" {
  name        = var.dev-webserver-name
  description = "ALB Security Group"
  vpc_id      = aws_vpc.main.id

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS trafic"
  }

  #outbound connexions
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# ALB_SG
resource "aws_security_group" "dev-alb-sg" {
  name        = "dev-alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP trafic"
  }

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS trafic"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Outbound trafic"
  }

  tags = {
    Name = "dev_alb_sg"
  }
}

#alb

resource "aws_lb" "dev-alb" {
  name               = "test-lb-tf"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.dev-alb-sg.id}"]
  subnets         = [aws_subnet.dev-public-subnet-01.id, aws_subnet.dev-public-subnet-02.id]

  tags = {
    Environment = "dev-alb"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev_igw"
  }

}