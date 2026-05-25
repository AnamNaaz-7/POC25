# ✅ VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

# ✅ Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-subnet"
  }
}

# ✅ Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

# ✅ Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id
}

# ✅ Route
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# ✅ Route Table Association
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.rt.id
}

# ✅ Security Group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ RANDOM ID (Fix for S3 unique name)
resource "random_id" "rand" {
  byte_length = 4
}

# ✅ S3 BUCKET (AUTO UNIQUE ✅)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "anjli-tf-${random_id.rand.hex}"
}

# ✅ EC2 INSTANCE (Free Tier ✅)
resource "aws_instance" "my_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "terraform-ec2"
  }
}
