output "vpc_id" {
  description = "ID da VPC TechNova"
  value       = aws_vpc.main.id
}

output "ec2_public_ip" {
  description = "IP público da EC2"
  value       = aws_instance.app.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do RDS PostgreSQL"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "Porta do RDS PostgreSQL"
  value       = aws_db_instance.postgres.port
}

output "rds_database" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.postgres.db_name
}