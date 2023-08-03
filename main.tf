# Create a VPC
resource "aws_vpc" "vscode_example_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

# create a subnet
resource "aws_subnet" "vscode_example_public_subnet" {
  vpc_id                  = aws_vpc.vscode_example_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "dev_public"
  }
}

# create internet_gateway
resource "aws_internet_gateway" "vscode_example_internet_gateway" {
  vpc_id = aws_vpc.vscode_example_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

# create public_route_table
resource "aws_route_table" "vscode_example_publicRT" {
  vpc_id = aws_vpc.vscode_example_vpc.id

  tags = {
    Name = "dev-publicRT"
  }
}

# create aws default route table
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.vscode_example_publicRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vscode_example_internet_gateway.id
}

# create aws route table association
resource "aws_route_table_association" "vscode_example_publicAssoc" {
  subnet_id      = aws_subnet.vscode_example_public_subnet.id
  route_table_id = aws_route_table.vscode_example_publicRT.id
}

# create security group
resource "aws_security_group" "vscode_example_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.vscode_example_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# create a key pair for ec2
resource "aws_key_pair" "vscode_example_auth" {
  key_name   = "vscodeTerraformKey"
  public_key = file("~/.ssh/vscodeTerraformKey.pub")
}

# create/launch ec2 instance
resource "aws_instance" "dev_instance_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.vscode_example_auth.id
  vpc_security_group_ids = [aws_security_group.vscode_example_sg.id]
  subnet_id              = aws_subnet.vscode_example_public_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    name = "dev_node"
  }
}