output "bucket_name" {
  value = aws_s3_bucket.terraform_state.arn
  description = "S3 ARN"
}

output "db_table_name" {
    value = aws_dynamodb_table.name.name  
}
