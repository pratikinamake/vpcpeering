 ######## VPC####################################

resource "aws_vpc" "primary" {
  cidr_block = "172.30.0.0/16"
  tags = {
      Name = "firstvpc"
    }
}


 
######################### Internet gateway (IGW).############################

 
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
}


 ####################* Route rule. #######################################
 

resource "aws_route" "primary-internet_access" {
  route_table_id         = aws_vpc.primary.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}


################## * Subnet. ############################################
 
resource "aws_subnet" "primary-az1" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.30.131.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2a"
}


################# * Subnet. #############################################
 
resource "aws_subnet" "primary-az2" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.30.132.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2b"
}


##################### * Security group. ###############################


resource "aws_security_group" "primary-default" {
  name_prefix = "default-"
  description = "Default security group for all instances in VPC ${aws_vpc.primary.id}"
  vpc_id      = aws_vpc.primary.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      aws_vpc.primary.cidr_block,
      aws_vpc.secondary.cidr_block,
    ]
  }

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

