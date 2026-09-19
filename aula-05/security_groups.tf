resource "aws_security_group" "ec2" {
  name        = "technova-ec2-sg"
  description = "Security Group da EC2 TechNova"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "API"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Saida para Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TechNova-EC2-SG"
  }
}

resource "aws_security_group" "rds" {
  name        = "technova-rds-sg"
  description = "Security Group do RDS PostgreSQL TechNova"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL somente da EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    description = "Saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TechNova-RDS-SG"
  }
}