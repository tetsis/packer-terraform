#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc_main" {
    cidr_block = "${var.root_segment}"
    tags {
        Name = "${var.app_name}"
    }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "vpc_main-igw" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    tags {
        Name = "${var.app_name} igw"
    }
}

#####################################
# Subnet Settings
#####################################
resource "aws_subnet" "vpc_main-subnet" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.subnet_segment}"
    availability_zone = "${var.subnet_segment_az}"
    tags {
        Name = "${var.app_name} subnet"
    }
}

#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "vpc_main-public-rt" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc_main-igw.id}"
    }
    tags {
        Name = "${var.app_name} public-rt"
    }
}

resource "aws_route_table_association" "vpc_main-rta" {
    subnet_id = "${aws_subnet.vpc_main-subnet.id}"
    route_table_id = "${aws_route_table.vpc_main-public-rt.id}"
}
