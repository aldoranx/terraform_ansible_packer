resource "aws_dynamodb_table" "planets" {
  name           = "planets"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "mercury" {
  table_name = aws_dynamodb_table.planets.name
  hash_key   = aws_dynamodb_table.planets.hash_key

  item = <<ITEM
{
  "id": {"S": "mercury"},
  "temp": {"S": "hot"}
}
ITEM
}

resource "aws_dynamodb_table_item" "mars" {
  table_name = aws_dynamodb_table.planets.name
  hash_key   = aws_dynamodb_table.planets.hash_key

  item = <<ITEM
{
  "id": {"S": "mars"},
  "temp": {"S": "cold"}
}
ITEM
}

resource "aws_dynamodb_table_item" "earth" {
  table_name = aws_dynamodb_table.planets.name
  hash_key   = aws_dynamodb_table.planets.hash_key

  item = <<ITEM
{
  "id": {"S": "earth"},
  "temp": {"S": "warm"}
}
ITEM
}