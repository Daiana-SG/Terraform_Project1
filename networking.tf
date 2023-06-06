//GATEWAY
resource "aws_internet_gateway" "gw_demo" {
  vpc_id = aws_vpc.demoVpc.id
}

# Associate an Elastic IP address with the NAT gateway (?)
resource "aws_eip" "eip_gw_demo" {
  vpc = true
}

# Define a NAT gateway to provide internet access to the private subnets
resource "aws_nat_gateway" "nat_gw_demo" {
  allocation_id = aws_eip.eip_gw_demo.id
  subnet_id     = aws_subnet.public_subnet1.id
}