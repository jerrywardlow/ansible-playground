# Load balancer
resource "aws_elb" "app" {
    name = "wordpress-elb"
    subnets = ["${aws_subnet.private.*.id}"]
    security_groups = ["${aws_security_group.elb.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    instances = ["${aws_instance.web-production.*.id}"]

    tags {
      group = "twc-elb"
    }
}
