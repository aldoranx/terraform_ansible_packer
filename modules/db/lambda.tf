module "iam" {
  source = "../iam"
  
}

# Archive a single file.
locals {
  lambda_zip_location = "outputs/lambda_function.zip"
}

data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "/home/aldo/terraform_ansible_packer/modules/db/lambda_function.py"
  output_path = local.lambda_zip_location
}

#Change lambda funtion name
resource "aws_lambda_function" "dev_lambda" {
  filename      = local.lambda_zip_location
  function_name = "getitems"
  role          = aws_iam_role.dev_iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  #source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.7"

}

resource "aws_iam_role" "dev_iam_for_lambda" {
  name = "dev_iam_for_lambda"

  assume_role_policy = "${file("/home/aldo/terraform_ansible_packer/modules/db/lambda_role.json")}"
}

resource "aws_iam_role_policy" "dev_lambda_policy" {
  name = "dev_lambda_policy"
  role = aws_iam_role.dev_iam_for_lambda.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("/home/aldo/terraform_ansible_packer/modules/db/lambda_policy.json")}"
}

resource "aws_iam_role_policy" "dev_lambda_exec_policy" {
  name = "dev_lambda_exec_policy"
  role = aws_iam_role.dev_iam_for_lambda.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("/home/aldo/terraform_ansible_packer/modules/db/lambda_exec_policy.json")}"
}

