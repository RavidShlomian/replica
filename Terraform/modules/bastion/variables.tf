#these are the variables in order to maintain modular code.

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  description = "Ubuntu machine image to use for ec2 instance"
  type        = string
  default     = "ami-04e49d62cf88738f1" # Ubuntu 22.04 LTS // eu-west-1
}

variable "sg_id" {
  description = "sg ID for EC2"
  type = string
}
variable "PbSubnet" {
    description = "public subnet for ec2"
}

variable "key_name" {
  type = string
  description = "bastion instance key pair"
  default = "bastion-key"
}