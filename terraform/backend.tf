
terraform {
  backend "s3" {
    bucket = "flask-project-remote-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"

  }
}