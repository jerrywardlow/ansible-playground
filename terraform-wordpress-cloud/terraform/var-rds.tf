# RDS Variables
variable "rds-identifier" {
    description = "Identifier for RDS"
    default = "wordpress-mysql"
}

variable "rds-instance-class" {
    description = "Instance class for RDS"
    default = "db.t2.micro"
}
