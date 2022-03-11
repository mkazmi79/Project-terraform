provider "aws" {
  region     = var.region
  access_key = var.a-key
  secret_key = var.s-key
}

#####################VPC##################

resource "aws_vpc" "vpc-tor" {
  cidr_block       = var.cidr-vpc
  instance_tenancy = "default"
  tags = local.my-tags
  
}

#####################Subnet-Public################

resource "aws_subnet" "sub-pub" {
  vpc_id     = aws_vpc.vpc-tor.id
  cidr_block = var.cidr-pub
  tags = local.my-tags

  }
#############Subnet-Private###############

resource "aws_subnet" "sub-private" {
  vpc_id     = aws_vpc.vpc-tor.id
  cidr_block = var.cidr-private
  tags = local.my-tags
  
}

##############EC2 Instance#####################

resource "aws_instance" "toronto" {
  ami           = var.image
  instance_type = var.ec2-tor
  tags = local.my-tags
  
}
#####################Security-Group###################

resource "aws_security_group" "tor-sg" {
  name        = "toronto-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-tor.id
  tags = local.my-tags

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  
}
###############ELB##########################
