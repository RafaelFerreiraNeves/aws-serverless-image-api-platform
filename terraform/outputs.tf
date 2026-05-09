output "api_url" {
  value = aws_api_gateway_stage.dev.invoke_url
}

output "bucket_name" {
  value = aws_s3_bucket.uploads.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.images.name
}