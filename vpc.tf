//VPC
resource "aws_vpc" "demoVpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "demoVpc"
  }
}

