provider "aws" {
  region = "us-east-1"
}

# Generate an SSH key pair and register it in AWS, saving the private key locally
resource "tls_private_key" "myec2key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "myec2key" {
  key_name   = "myec2key"
  public_key = tls_private_key.myec2key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "myec2key.pem"
  content         = tls_private_key.myec2key.private_key_pem
  file_permission = "0400"
}

# Create default VPC
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default vpc"
  }
}

# Get availability zones
data "aws_availability_zones" "available_zones" {}

# Create default subnet
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "default subnet"
  }
}

# Security group for EC2
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 80 and 22"
  vpc_id      = aws_default_vpc.default_vpc.id

  # HTTP
  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2 security group"
  }
}

# Get latest Amazon Linux 2 x86_64 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Launch EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  subnet_id = aws_default_subnet.default_az1.id

  vpc_security_group_ids = [
    aws_security_group.ec2_security_group.id
  ]

  key_name = aws_key_pair.myec2key.key_name

  user_data = file("install_techmax.sh")

  tags = {
    Name = "techmax server"
  }
}

# Output public URL
output "ec2_public_ipv4_url" {
  value = join("", [
    "http://",
    aws_instance.ec2_instance.public_ip
  ])
}

# Output SSH command
output "ssh_command" {
  value = join("", [
    "ssh -i myec2key.pem ec2-user@",
    aws_instance.ec2_instance.public_ip
  ])
}