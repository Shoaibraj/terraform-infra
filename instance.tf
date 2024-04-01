# Create VPC, subnets, and internet gateway (assuming they are not already created)

# Create security group allowing all inbound traffic
resource "aws_security_group" "all_inbound" {
  name        = "all-inbound-sg"
  description = "Security group allowing all inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id  # Update with your VPC ID

  ingress {
    from_port   = 0
    to_port     = 65535  # Allow all ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from all sources (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security groups (assuming they are already defined in your configuration)

# Create public EC2 instance
resource "aws_instance" "public_instance" {
  ami           = "ami-0c101f26f147fa7fd"  # Specify your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id  # Reference the public subnet resource
  key_name      = "node.js"  # Update with your key pair name

  # Associate security group with the instance
  vpc_security_group_ids = [aws_security_group.all_inbound.id]

  tags = {
    Name = "Public Instance"
  }
}

# Create private EC2 instance
resource "aws_instance" "private_instance" {
  ami           = "ami-0c101f26f147fa7fd"  # Specify your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id  # Reference the private subnet resource
  key_name      = "node.js"  # Update with your key pair name

  # Associate security group with the instance
  vpc_security_group_ids = [aws_security_group.all_inbound.id]

  tags = {
    Name = "Private Instance"
  }
}

