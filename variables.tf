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

variable "aws_key_name" {
    default = "webserver"
}

variable "private_key_path" {
    default = "webserver.pem"
}