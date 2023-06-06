//API GATEWAY
resource "aws_api_gateway_rest_api" "api_demo" {
  name        = "api_demo"
  description = "API Gateway for accessing texto.txt"
}

//Create a resource and method in the API Gateway 
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_demo.id
  parent_id   = aws_api_gateway_rest_api.api_demo.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.api_demo.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "POST"
  authorization = "NONE"
}

//Add an integration to the method
resource "aws_api_gateway_integration" "lambda_proxy" {
  rest_api_id             = aws_api_gateway_rest_api.api_demo.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api_demo.invoke_arn
}

resource "aws_api_gateway_deployment" "api_dev" {
  depends_on = [
    "aws_api_gateway_integration.lambda_proxy",
    "aws_api_gateway_integration.lambda_proxy",
  ]

  rest_api_id = aws_api_gateway_rest_api.api_dev.id
  stage_name  = "test"
}

//https://registry.terraform.io/providers/hashicorp/aws/2.34.0/docs/guides/serverless-with-aws-lambda-and-api-gateway
