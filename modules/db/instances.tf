/*
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "my-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Id"
  range_key      = "GameTitle"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    Name        = "dev-dynamodb-table-1"
    Environment = "dev"
  }
}
*/