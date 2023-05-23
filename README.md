# Terraform_Project1 - Objective
Build an infra in Terraform with the following requirements so that it can be executed by a client
Everything with HA and secured (principle of least possible permission).
Only 1 Network(VPC) of 4096 ips.
Only 4 Subnets of 256 ips (two public, two private with Internet access)
A bucket with a file called text.txt and contains the string "Hello World."
Entry point, an APIGW that sends traffic to Lambda.
Application, a Lambda that returns the content of the file texto.txt. The code can be in any language.
