output "state_bucket_name" {
  description = "Nome do bucket S3 usado para o Terraform State"
  value       = "technova-terraform-state-468464606980"
}

output "lock_table_name" {
  description = "Nome da tabela DynamoDB usada para o lock"
  value       = aws_dynamodb_table.terraform_lock.name
}