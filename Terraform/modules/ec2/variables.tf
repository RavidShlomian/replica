#these are the variables in order to maintain modular code.
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  description = "amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-04e49d62cf88738f1" # amazon linux // eu-west-1
}

variable "sg_id" {
  description = "sg ID for EC2"
  type = string
}


variable "key_name" {
  type = string
  description = "nginx instance key pair"
  default = "moveo-key"
} 

variable "PrSubnet" {
    description = "private subnet for ec2"
}