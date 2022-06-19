terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "eu-central-1"

}

terraform {
  backend "s3" {
    bucket = "hhh-back-state"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
#     access_key =  ${{env.AWS_ACCESS_KEY}}
#     secret_key =  ${{env.AWS_SECRET_KEY}}
  }
}

resource "aws_instance" "web" {
  ami           = var.MY_AMI
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.dos07_terraform_sg.id]
  user_data = templatefile("user_data.sh.tpl", {
    my_name     = "TERRAFORM-DOS07-PIPELINE"
})
}

resource "aws_security_group" "dos07_terraform_sg" {
  name        = "PipeLine12345"
  description = "TerraformSGroup for dos07"
  vpc_id      = var.My_VPC

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformSGroupPipeline"
  }
}

# resource "aws_lb" "test" {
#   name               = "dos07-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.dos07_terraform_sg.id]
#   subnets            = ["subnet-07dd4607843ee1be3","subnet-0a415f92b7240ef76"] 

#   #enable_deletion_protection = true

#   # access_logs {
#   #   bucket  = aws_s3_bucket.lb_logs.bucket
#   #   prefix  = "test-lb"
#   #   enabled = true
#   # }

#   tags = {
#     Environment = "production"
#   }
# }


# resource "aws_lb_target_group" "tf-dos07-lb-tg" {
#   name        = "tf-dos07-lb-tg"
#  # target_type = "alb"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = var.My_VPC
# }

# resource "aws_lb_target_group_attachment" "attach" {
#   target_group_arn = aws_lb_target_group.tf-dos07-lb-tg.arn
#   target_id        = aws_instance.web.id
#   port             = 80
# }

# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.test.arn
#   port              = "80"
#   protocol          = "HTTP"
#   #ssl_policy        = "ELBSecurityPolicy-2016-08"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tf-dos07-lb-tg.arn
#   }
# }

# # variable "vpc_id" {}

# # data "aws_vpc" "setka" {
# #   id = var.My_VPC
# # }

# # resource "aws_subnet" "example" {
# #   vpc_id            = data.aws_vpc.selected.id
# #   availability_zone = "us-west-2a"
# #   cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)
# # }
