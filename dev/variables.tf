variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "ami_id" {
  default = "ami-00399ec92321828f5 "
}

variable "dev-webserver-pub-sub-01" {
  default = "10.0.1.0/24"
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

variable "alb_name" {
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
