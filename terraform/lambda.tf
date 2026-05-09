data "archive_file" "upload_zip" {
  type        = "zip"
  source_dir  = "../lambda-upload"
  output_path = "../lambda-upload.zip"
}

data "archive_file" "processor_zip" {
  type        = "zip"
  source_dir  = "../lambda-processor"
  output_path = "../lambda-processor.zip"
}

resource "aws_lambda_function" "upload_lambda" {
  function_name = "upload-lambda"

  role    = aws_iam_role.lambda_role.arn
  handler = "index.handler"
  runtime = "nodejs18.x"

  filename         = data.archive_file.upload_zip.output_path
  source_code_hash = data.archive_file.upload_zip.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.uploads.bucket
    }
  }
}

resource "aws_lambda_function" "processor_lambda" {
  function_name = "processor-lambda"

  role    = aws_iam_role.lambda_role.arn
  handler = "index.handler"
  runtime = "nodejs18.x"

  filename         = data.archive_file.processor_zip.output_path
  source_code_hash = data.archive_file.processor_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images.name
    }
  }
}
