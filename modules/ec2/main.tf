resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.key_pair_name
  public_key = var.key_pair
}


resource "aws_instance" "public_ec2_instance" {
  count                       = var.public_ec2 ? 1 : 0
  ami                         = var.ami_name
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_keypair.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  depends_on                  = [aws_key_pair.ec2_keypair, aws_security_group.ec2-sg]
  tags                        = var.ec2_tags
  associate_public_ip_address = true
  root_block_device {
    volume_size = var.ec2_volume
  }
}

resource "aws_instance" "private_ec2_instance" {
  count                       = var.private_ec2 ? 1 : 0
  ami                         = var.ami_name
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_keypair.key_name
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  depends_on                  = [aws_key_pair.ec2_keypair, aws_security_group.ec2-sg]
  tags                        = var.ec2_tags
  associate_public_ip_address = false
  root_block_device {
    volume_size = var.ec2_volume
  }
}

resource "aws_security_group" "ec2-sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

