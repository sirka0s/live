output "rds_address" {
    value       = aws_db_instance.example.address
    description = "Connect to DB at this endpoint"
}

output "rds_port" {
  value       = aws_db_instance.example.port
  description = "Connect to DB at this port"
}