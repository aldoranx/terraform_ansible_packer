variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "vpc-id" {
  description = "aws_vpc.main.id"
}

variable "all-connexion-allowed" {
  default = "0.0.0.0/0"
}

variable "dev-pub-sub-01" {
  default = "10.0.1.0/24"
}

variable "dev-pub-sub-02" {
  default = "10.0.2.0/24"
}

variable "dev-webserver-name" {
  default = "10.0.3.0/24"
}

variable "internal" {
  default = "false"
}

variable "name" {
  default = "dev-alb"
}

variable "alb" {
  default = "application"
}

variable "dev_public_subnets" {
  default = {
    dev-public-subnet-01 = "dev-public-subnet-01"
    dev-public-subnet-02 = "dev-public-subnet-02"

  }
}

variable "http_port" {
  default = "80"
}

variable "backend_protocol" {
  default = "HTTP"
}




