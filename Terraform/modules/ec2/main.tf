#instance for nginx container deployment with user data script.
resource "aws_instance" "moveo_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = aws_key_pair.moveo_key_pair.key_name
  vpc_security_group_ids = [var.sg_id]
  availability_zone    = "eu-west-1b"
  subnet_id            = var.PrSubnet
  tags = {
    Name    = "moveo-task-instance"
  }
  user_data = file("server_setup.sh")
  depends_on = [aws_key_pair.moveo_key_pair]
  
}

resource "aws_key_pair" "moveo_key_pair" {
  key_name   = var.key_name
  public_key = file("moveo-pub-key.pem")
}

/* 
resource "aws_eip" "lb" {
  instance = aws_instance.moveo_instance.id
  domain   = "vpc"
  tags = {
   Name = "moveo_instance_ip"
  }
}
*/