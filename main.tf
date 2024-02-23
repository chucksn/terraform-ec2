module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-vpc"
  cidr = "192.168.0.0/20"

  azs            = ["${var.region-1}a", "${var.region-1}b", "${var.region-1}c"]
  public_subnets = ["192.168.0.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

data "local_file" "public_key" {
  filename = "${path.module}/key.pub"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.project_name}-keypair"
  public_key = data.local_file.public_key.content
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.project_name}-server"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-sg"

  tags = {
    Name = "${var.project_name}-sg"
  }
}

resource "aws_security_group_rule" "allow_all_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}