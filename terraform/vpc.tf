# add vpc

resource "aws_vpc" "aws-vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.app_name}-vpc"
    Environment = "${var.app_environment}"
  }
}

# add network




