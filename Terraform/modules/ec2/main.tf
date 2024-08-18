resource "aws_instance" "moveo_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = "moveo-key"
  vpc_security_group_ids = [var.sg_id]
  availability_zone    = "eu-north-1b"
  subnet_id            = var.PrSubnet
  tags = {
    Name    = "moveo-task-instance-1"
  }
  user_data = file("server_setup.sh")
  

}

resource "aws_eip" "lb" {
  instance = aws_instance.moveo_instance.id
  domain   = "vpc"
  tags = {
   Name = "moveo_instance_ip"
  }
}