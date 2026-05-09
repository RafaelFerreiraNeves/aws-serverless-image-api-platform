resource "aws_dynamodb_table" "images" {
  name         = "images-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}