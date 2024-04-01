# Define RDS subnet group covering multiple AZs
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,  # Subnet in us-east-1b
    aws_subnet.private_subnet_2.id,  # Subnet in us-east-1c
  ]
  tags = {
    Name = "My DB Subnet Group"
  }
}


# Define RDS security group (allow necessary inbound rules)
resource "aws_security_group" "db_security_group" {
  name        = "db-security-group"
  description = "Security group for RDS MariaDB"
  vpc_id      = aws_vpc.my_vpc.id

  # Example rule: allow MySQL/Aurora connections from within the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]  # Update with your VPC CIDR block
  }

  tags = {
    Name = "DB Security Group"
  }
}

# Create RDS instance
resource "aws_db_instance" "my_db_instance" {
  identifier            = "my-db-instance"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "mariadb"
  engine_version        = "10.11"
  instance_class        = "db.t3.micro"  # Free Tier eligible instance class
  db_name               = "studentapp"
  username              = "admin"
  password              = "ASDFasdf123"
  db_subnet_group_name  = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
}
