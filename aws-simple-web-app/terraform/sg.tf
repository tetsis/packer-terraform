#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "app_sg" {
    name = "app_sg"
    vpc_id = "${aws_vpc.vpc_main.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.allow_ip}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "allow 80/tcp"

    tags = {
        Name = "${var.app_name} app_sg"
    }
}
