resource "aws_security_group" "acesso_ssh_icmp_publico" {
  name        = "acesso_ssh_icmp_publico"
  description = "acesso_ssh_icmp_publico"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "acesso_ssh_icmp_publico"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "management" {

  count = 2

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  associate_public_ip_address = true

  subnet_id              = module.vpc.public_subnets[count.index % length(var.public_subnet_cidr_blocks)]
  vpc_security_group_ids = [aws_security_group.acesso_ssh_icmp_publico.id]
  key_name = "aws-terraform-multi-env-dev"

  tags = {
    Name = "mngt-${count.index}"
  }
}
