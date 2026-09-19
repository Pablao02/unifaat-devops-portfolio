resource "aws_key_pair" "technova" {
  key_name   = "technova-key"
  public_key = file("technova-key.pub")

  tags = {
    Name = "technova-key"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "api" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_az1.id
  vpc_security_group_ids = [aws_security_group.api.id]
  key_name               = aws_key_pair.technova.key_name

  iam_instance_profile = data.aws_iam_instance_profile.lab_profile.name

  user_data_replace_on_change = true
  user_data                    = file("${path.module}/user_data.sh")

  tags = {
    Name = "technova-api-ec2"
  }
}