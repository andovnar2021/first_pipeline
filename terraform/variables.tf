variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "my_app_flask"
}

variable "app_environment" {
  type        = string
  description = "Application Name"
  default     = "test"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "availability_zones" {
  description = "List of availability zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "my-app-cluster"
}

variable "path_to_file" {
  type        = string
  description = "path to file container-definitions"
  default     = "container-definitions/container-def.json"
}

variable "container_name" {
  type        = string
  description = "Container name"
  default     = "my-flask-app"
}