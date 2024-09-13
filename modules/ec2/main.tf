resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.key_pair_name
  public_key = var.key_pair
}


resource "aws_instance" "ec2_instance" {
  ami           = var.ami_name
  instance_type = var.instance_type
  key_name = aws_key_pair.ec2_keypair.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids= [aws_security_group.ec2-sg.id]
  depends_on = [ aws_key_pair.ec2_keypair,aws_security_group.ec2-sg ]
  tags = var.ec2_tags
  associate_public_ip_address = true
}

resource "aws_security_group" "ec2-sg" {
    vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress  {

from_port =22
to_port = 22
protocol= "tcp"
cidr_blocks=["0.0.0.0/0"]

  }

    ingress  {

from_port =-1
to_port = -1
protocol= "icmp"
cidr_blocks=["0.0.0.0/0"]

  }
}

