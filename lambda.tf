//LAMBDA
resource "aws_lambda_function" "lambda_demo" {
  filename         = "lambda_demo-lambda.zip" # Path to your Lambda function code* (??)
  function_name    = "lambda_demo"
  role             = aws_iam_role.lambda_demoLambdaRole.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("lambda_demo-lambda.zip") # Hash of your Lambda function code

}

//permisos sobre la lambda para que pueda ser llamada desde el API gateway
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_demo.function_name
  principal     = "events.amazonaws.com"
  source_arn    = "arn:aws:events:eu-west-1:111122223333:rule/RunDaily"
  qualifier     = aws_lambda_alias.test_alias.name
}