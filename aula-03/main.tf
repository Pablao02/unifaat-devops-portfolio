# =========================
# Grupos IAM
# =========================

resource "aws_iam_group" "developers" {
  name = "${var.ra}-technova-developers"
}

resource "aws_iam_group" "platform_eng" {
  name = "${var.ra}-technova-platform-eng"
}

# =========================
# Usuários IAM
# =========================

resource "aws_iam_user" "juliana_dev" {
  name = "${var.ra}-juliana-dev"
}

resource "aws_iam_user" "rafael_platform" {
  name = "${var.ra}-rafael-platform"
}

resource "aws_iam_user" "lucas_intern" {
  name = "${var.ra}-lucas-intern"
}

# =========================
# Associação de usuários
# =========================

resource "aws_iam_user_group_membership" "juliana_dev" {
  user = aws_iam_user.juliana_dev.name

  groups = [
    aws_iam_group.developers.name
  ]
}

resource "aws_iam_user_group_membership" "rafael_platform" {
  user = aws_iam_user.rafael_platform.name

  groups = [
    aws_iam_group.developers.name,
    aws_iam_group.platform_eng.name
  ]
}

resource "aws_iam_user_group_membership" "lucas_intern" {
  user = aws_iam_user.lucas_intern.name

  groups = [
    aws_iam_group.developers.name
  ]
}