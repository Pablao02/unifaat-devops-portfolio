# Aula 03 — Terraform + IAM Completo

## Disciplina

DevOps - UniFAAT 2026-2

## Projeto

TechNova

## Aluno

Pablo Augusto Ramos Sobral

## RA

6325076

---

# 1. Objetivo

Nesta atividade foi desenvolvido um projeto de infraestrutura como código utilizando Terraform para provisionar e configurar recursos de IAM na AWS.

O objetivo é aplicar conceitos de:

- Terraform;
- IAM;
- grupos e usuários;
- políticas customizadas;
- princípio do menor privilégio;
- permissões condicionais;
- negação explícita de ações destrutivas;
- IAM Role para EC2;
- Instance Profile;
- organização e documentação de infraestrutura como código.

---

# 2. Estrutura do projeto

```text
aula-03/
├── .gitignore
├── main.tf
├── outputs.tf
├── policies.tf
├── providers.tf
├── roles.tf
├── terraform-plan-output.txt
├── variables.tf
└── README.md