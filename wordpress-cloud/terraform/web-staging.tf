# Staging server
resource "aws_instance" "web-staging" {
    ami = "${var.ubuntu-ami}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public.id}"
    vpc_security_group_ids = ["${aws_security_group.web_staging.id}"]
    key_name = "${aws_key_pair.wordpress.key_name}"
    tags = {
        name = "wordpress-web-staging"
        group = "staging"        
    }
}
