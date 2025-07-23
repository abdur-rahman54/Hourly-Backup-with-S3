# terraform/main.tf
resource "aws_s3_bucket" "backups" {
  bucket = "your-db-backups"
  versioning { enabled = true }  # Ransomware protection
}

resource "aws_lambda_function" "backup" {
  filename      = "src/backup_lambda.zip"
  function_name = "db-backup"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "backup_lambda.lambda_handler"
  runtime       = "python3.10"
  environment {
    variables = {
      DB_HOST = aws_secretsmanager_secret_version.db_creds.secret_string
    }
  }
}
