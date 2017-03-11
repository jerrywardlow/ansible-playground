# RDS instance
resource "aws_db_instance" "mysql" {
    identifier = "${var.rds-identifier}"
    instance_class = "${var.rds-instance-class}"
    allocated_storage = 5
    storage_type = "gp2"
    engine = "mysql"
    multi_az = false

    name = "wordpressdb"
    username = "dbuser"
    password = "dbpassword"

    vpc_security_group_ids = ["${aws_security_group.mysql.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.default.name}"
    
    tags {
      group = "twc-rds"
    }
}

# RDS subnet group
resource "aws_db_subnet_group" "default" {
    name = "main"
    description = "Subnet group for RDS/MySQL"
    subnet_ids = ["${aws_subnet.private.*.id}"]
    tags {
        Name = "wordpress-db-subnet-group"
    }
}
