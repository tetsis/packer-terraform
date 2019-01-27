#####################################
# EC2 Settings
#####################################
resource "aws_instance" "app_main" {
    ami           = "${var.ami}"
    associate_public_ip_address = "true"
    instance_type = "t2.micro"
    subnet_id     = "${aws_subnet.vpc_main-subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]

    tags = {
        Name = "${var.app_name} instance"
    }
}

output "public_ip" {
  value = "${aws_instance.app_main.public_ip}"
}

