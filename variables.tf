variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "db_name" {
}
variable "db_username" {
}
variable "db_password" {
}

# vpc variables
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "public_subnet_cidr_2" {
    default = "10.0.1.0/24"
}

variable "allow_all" {
    default = "0.0.0.0/0"
}

# ec2 variables
variable "aws_key_name" {
    default = "webserver"
}

variable "private_key_path" {
    default = "webserver.pem"
}

# cluster variables
variable "ecs_cluster" {
    default = "docker-demo-cluster"
}

variable "min_instance_size" {
    default = 1
}

variable "max_instance_size" {
    default = 3
}

variable "desired_capacity" {
    default = 1
}