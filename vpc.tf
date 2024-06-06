# Creación VPC
resource "aws_vpc" "vpc_reto" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_reto"
  }
}

#comentario

resource "aws_subnet" "subnet1_vpc_reto" {
  vpc_id            = aws_vpc.vpc_reto.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1_vpc_reto"
  }
}

resource "aws_subnet" "subnet2_vpc_reto" {
  vpc_id            = aws_vpc.vpc_reto.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet2_vpc_reto"
  }
}

resource "aws_subnet" "subnet3_vpc_reto" {
  vpc_id            = aws_vpc.vpc_reto.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet3_vpc_reto"
  }
}

resource "aws_db_subnet_group" "db" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.subnet1_vpc_reto.id, aws_subnet.subnet2_vpc_reto.id, aws_subnet.subnet3_vpc_reto.id]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_internet_gateway" "gw_reto" {
  vpc_id = aws_vpc.vpc_reto.id

  tags = {
    Name = "gw_reto"
  }
}

resource "aws_route_table" "rt_reto" {
  vpc_id = aws_vpc.vpc_reto.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_reto.id
  }

  tags = {
    Name = "rt_reto"
  }
}

resource "aws_route_table_association" "a_rt_reto_subnet1" {
  subnet_id      = aws_subnet.subnet1_vpc_reto.id
  route_table_id = aws_route_table.rt_reto.id
}

resource "aws_route_table_association" "a_rt_reto_subnet2" {
  subnet_id      = aws_subnet.subnet2_vpc_reto.id
  route_table_id = aws_route_table.rt_reto.id
}

resource "aws_route_table_association" "a_rt_reto_subnet3" {
  subnet_id      = aws_subnet.subnet3_vpc_reto.id
  route_table_id = aws_route_table.rt_reto.id
}
