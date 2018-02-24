resource "aws_vpc" "ecs_cluster_vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "demo-cluster-vpc"
        Terraform = true
    }
}

resource "aws_internet_gateway" "ecs_cluster_igw" {
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"

    tags = {
        Name = "igw"
        Terraform = true
    }
}

resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"
    availability_zone = "us-east-1a"
    cidr_block = "${var.public_subnet_cidr}"

    tags {
        Name = "Public Subnet"
        Terraform = true
    }
}

resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"
    availability_zone = "us-east-1b"
    cidr_block = "${var.public_subnet_cidr_2}"

    tags {
        Name = "Public Subnet 2"
        Terraform = true
    }
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"

    route {
        cidr_block = "${var.allow_all}"
        gateway_id = "${aws_internet_gateway.ecs_cluster_igw.id}"
    }

    tags {
        Name = "Public Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

resource "aws_route_table" "us-east-1b-public" {
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"

    route {
        cidr_block = "${var.allow_all}"
        gateway_id = "${aws_internet_gateway.ecs_cluster_igw.id}"
    }

    tags {
        Name = "Public Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "us-east-1b-public" {
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-1b-public.id}"
}

resource "aws_security_group" "public_sg" {
    name = "PublicSG"
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.allow_all}"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.allow_all}"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.allow_all}"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["${var.allow_all}"]
    }

    tags {
        Name = "Public SG"
        Terraform = true
    }
}