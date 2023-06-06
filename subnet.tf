//SUBNETS
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.demoVpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name : "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.demoVpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1b"
  tags = {
    Name : "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  vpc_id            = aws_vpc.demoVpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1a"
  //depends_on = [aws_internet_gateway.gw_demo] # Create a NAT gateway to provide internet access to this subnet
  tags = {
    Name : "private_subnet3"
  }

}

resource "aws_subnet" "private_subnet4" {
  vpc_id            = aws_vpc.demoVpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "us-east-1b"
  //depends_on = [aws_internet_gateway.gw_demo]//[nat_gw_demo] ver como es realmente
  tags = {
    Name : "private_subnet4"
  }
}
