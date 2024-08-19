#bastion server for ssh directly to the nginx container deployment instance.
resource "aws_instance" "bastion_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = "bastion-key"
  vpc_security_group_ids = [var.sg_id]
  availability_zone    = "eu-north-1a"
  subnet_id            = var.PbSubnet
  tags = {
    Name    = "bastion-instance"
  }

    user_data = <<-EOF
      #!/bin/bash
      apt-get update -y
      #Adding the public key for ssh connections 
      echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpsezp6/aliZYsWvZz/Tw1LidT7+8w+mxGwC9WTFwPzmu8A886CJVSN9ZEAIRUp+aerx6m5KVD1QCwUhu8pLrgZXeLSaFZOGrtRfmygsOs2FYEj70n6Ln5nPfjQH81Ccd4Sx7W6tWlnaCZFUVuemyk4njEkNCU+Ew4qhHJu91A4Y2/mdZ9acAGd6yyQPmgQV0MuxHZLzG15L3MTwldb8TcyNhjd2tjkbKtFyYuQdJS4TaUVYQ/+YIJD2uaNk1AxzzO8wTN53tj9ESvtX2g1+6jXjetHU+lmGr6FVs7QaBSovIPhIJDDqIklIiwP1VOkeLA3ec+50IQARE3BEXou3aF" >> /home/ubuntu/.ssh/authorized_keys/

    EOF
}