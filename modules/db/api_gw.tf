resource "aws_apigatewayv2_api" "getitems" {
  name          = "getitems"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.getitems.id
  name        = "dev"
}

resource "aws_apigatewayv2_integration" "getitems" {
  api_id = aws_apigatewayv2_api.getitems.id

  integration_uri    = aws_lambda_function.dev_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "getitems" {
  api_id = aws_apigatewayv2_api.getitems.id

  route_key = "ANY /getitems"
  target    = "integrations/${aws_apigatewayv2_integration.getitems.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dev_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.getitems.execution_arn}/*/*"
}