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