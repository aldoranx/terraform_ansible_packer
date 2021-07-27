#VPC
variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "vpc-id" {
  description = "aws_vpc.main.id"
}


#Subnets
variable "all-connexion-allowed" {
  default = "0.0.0.0/0"
}

variable "dev-pub-sub-01" {
  default = "10.0.1.0/24"
}

variable "dev-pub-sub-02" {
  default = "10.0.2.0/24"
}

variable "dev_public_subnets" {
  default = {
    dev-public-subnet-01 = "dev-public-subnet-01"
    dev-public-subnet-02 = "dev-public-subnet-02"

  }
}


#WebServer
variable "dev-webserver-name" {
  default = "10.0.3.0/24"
}

#ALB
variable "internal" {
  default = "false"
}

variable "alb-name" {
  default = "dev-alb"
}

variable "load-balencer-type" {
  default = "application"
}


variable "http-port" {
  default = "80"
}

variable "backend-protocol" {
  default = "HTTP"
}
variable "protocol-http" {
  default = "HTTP"
}

variable "protocol-https" {
  default = "HTTPS"
}

variable "https-port" {
  default = "443"
}


#certif variables
variable "acme_email" {
  type    = string
  default = "geraldwork1@gmail.com"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "domain_name" {
  type    = string
  default = "ranx-on-aws.com"
}

#route53
variable "applicative_env" {
  type    = string
  default = "dev"
}


