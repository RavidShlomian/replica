#these are the variables in order to maintain modular code.
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  description = "amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-02af70169146bbdd3" # amazon linux // eu-north-1
}

variable "sg_id" {
  description = "sg ID for EC2"
  type = string
}
variable "PrSubnet" {
    description = "private subnet for ec2"
}