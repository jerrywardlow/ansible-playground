# RDS instance
resource "aws_db_instance" "mysql" {
    identifier = "wordpress-mysql"
    instance_class = "db.t2.micro"
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
        uuid = "${var.rds_uuid_tag}"
    }
}

# RDS subnet group
resource "aws_db_subnet_group" "default" {
    name = "main"
    description = "Subnet group for RDS/MySQL - Zones 2b and 2c"
    subnet_ids = ["${aws_subnet.rds1.id}", "${aws_subnet.rds2.id}"]
    tags {
        name = "wordpress-db-subnet-group"
    }
}
