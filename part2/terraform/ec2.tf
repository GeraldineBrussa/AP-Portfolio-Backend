
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "key"
  public_key = file("${path.module}/sshkey.pub")
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "jumphost" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  subnet_id                   = element(module.vpc.public_subnets,0)
  key_name                    = module.key_pair.key_pair_key_name
  vpc_security_group_ids      = [aws_security_group.jump_host.id]
  associate_public_ip_address = true

  tags = local.common_tags

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum -y install mariadb unzip"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./sshkey")
      host        = self.public_ip
    }
  }

}

