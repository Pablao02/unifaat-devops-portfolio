variable "db_name" {
  description = "Nome do banco de dados PostgreSQL"
  type        = string
  default     = "technova"
}

variable "db_username" {
  description = "Usuário do banco de dados PostgreSQL"
  type        = string
  default     = "technova_admin"
}

variable "db_password" {
  description = "Senha do banco de dados PostgreSQL"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "Nome do Key Pair da AWS para acesso SSH"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR autorizado para SSH"
  type        = string
  default     = "0.0.0.0/0"
}