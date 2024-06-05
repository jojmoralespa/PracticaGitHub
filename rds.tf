# Creación de Base de datos RDS
resource "aws_db_instance" "default" {
  identifier             = "reto-rds"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.36"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.db.name
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "reto-rds"
  }
}
