output "all_users" {
  value = values(aws_iam_user.example)[*].arn
}

output "upper_names" {
  value = [for name in var.user_name : upper(name) if length(name) < 4]
}

#To output a map
output "upper_roles" {
  value = {for name, role in var.heroes : upper(name) => upper(role)}
}

#To output a list
output "roles" {
  value = [for name, role in var.heroes : "${name} is the ${role}"]
}

#Loop within string
output "stringy" {
  value = <<EOT
  %{ for name in var.user_name ~}
  ${name}
  %{ endfor ~}
  EOT
}