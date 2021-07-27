#Import Provider
terraform {
  required_providers {
    acme = {
      source = "vancluever/acme"
      version = "~> 2.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "acme" {
  alias      = "production"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

/*
provider "tls" {
  version = "3.1.0"
}
*/

# Create Account on ACME Server

resource "tls_private_key" "staging_account_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "acme_registration" "staging_account_registration" {
  account_key_pem = tls_private_key.staging_account_private_key.private_key_pem
  email_address   = var.acme_email
}

resource "tls_private_key" "production_account_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
  
  lifecycle {
    prevent_destroy = true
  }
}

resource "acme_registration" "production_account_registration" {
  provider        = acme.production
  account_key_pem = tls_private_key.production_account_private_key.private_key_pem
  email_address   = var.acme_email

  lifecycle {
    prevent_destroy = true
  }
}

# Generate First Certificat

provider "aws" {
  region  = var.region
}

resource "aws_route53_zone" "main_public_route53_zone" {
  name    = "${var.domain_name}."
  comment = "Main internet public domain"

  lifecycle {
    prevent_destroy = true
  }
}

resource "acme_certificate" "devfactory_certificate" {
  account_key_pem = acme_registration.staging_account_registration.account_key_pem
  
  common_name = "www.example.com"
  subject_alternative_names = [
    "sonarqube.${var.domain_name}"
  ]

  recursive_nameservers = [
    "${aws_route53_zone.main_public_route53_zone.name_servers.0}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.1}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.2}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.3}:53",
  ]

  dns_challenge {
    provider = "route53"
    
    config = {
      AWS_HOSTED_ZONE_ID = aws_route53_zone.main_public_route53_zone.zone_id
    }
  }
}

