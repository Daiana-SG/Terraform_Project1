provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}
//VPC
resource "aws_vpc" "demoVpc"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "demoVpc"
    }
}
//GATEWAY
resource "aws_internet_gateway" "gw_demo"{
    vpc_id = aws_vpc.demoVpc.id 
}

//SUBNETS
resource "aws_subnet" "public_subnet1"{
    vpc_id = aws_vpc.demoVpc.id 
    cidr_block = "10.0.0.0/20"
    availability_zone = "us-east-1a" 
    tags = {
      Name: "public_subnet1"
    }
}

resource "aws_subnet" "public_subnet2"{
    vpc_id = aws_vpc.demoVpc.id 
    cidr_block = "10.0.16.0/20"
    availability_zone = "us-east-1b" 
    tags = {
      Name: "public_subnet2"
    }
}

resource "aws_subnet" "private_subnet3"{
    vpc_id = aws_vpc.demoVpc.id  
    cidr_block = "10.0.32.0/20"
    availability_zone = "us-east-1a" 
    //depends_on = [aws_internet_gateway.gw_demo] # Create a NAT gateway to provide internet access to this subnet
    tags = {
      Name: "private_subnet3"
    }

}

 resource "aws_subnet" "private_subnet4"{
    vpc_id = aws_vpc.demoVpc.id 
    cidr_block = "10.0.48.0/20"
    availability_zone = "us-east-1b" 
    //depends_on = [aws_internet_gateway.gw_demo]//[nat_gw_demo] ver como es realmente
    tags = {
      Name: "private_subnet4"
    }
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

# Define security groups to allow inbound and outbound traffic
resource "aws_security_group" "public_inbound" {
  name_prefix = "public-inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["190.19.50.32/32"]
  }
}

resource "aws_security_group" "public_outbound" {
  name_prefix = "public-outbound"

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "private_inbound" {
  name_prefix = "private-inbound"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "private_outbound" {
  name_prefix = "private-outbound"

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#BUCKET S3
resource "aws_s3_bucket" "bucket_demo"{
    bucket = "s3-terraform-bucket-lab"
    //acl    = "private"   
    tags ={
        Name = "bucket_demo"
        Environment = "Dev"
    }
}
resource "aws_s3_bucket_acl" "bucket_demo_ACL" {
    bucket = aws_s3_bucket.bucket_demo.id
    acl = "private"
}

resource "aws_s3_bucket_object" "TextoPrueba"{
    bucket = aws_s3_bucket.bucket_demo.id
    key    = "text.txt"
    content = "Hello World."

}
