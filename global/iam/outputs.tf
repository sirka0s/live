output "neo_arn" {
  value = aws_iam_user.example[0].arn
  description = "ARN for Neo"
}

output "all_arns" {
  value = aws_iam_user.example[*].arn
  description = "ARN for all users"
}