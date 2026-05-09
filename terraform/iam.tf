resource "aws_iam_role" "lambda_role" {
  name = "serverless-demo-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"

      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "serverless-demo-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:*"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:*"
        ]

        Resource = [
          aws_s3_bucket.uploads.arn,
          "${aws_s3_bucket.uploads.arn}/*"
        ]
      },

      {
        Effect = "Allow"

        Action = [
          "dynamodb:*"
        ]

        Resource = aws_dynamodb_table.images.arn
      }
    ]
  })
}