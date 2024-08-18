variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  description = "Ubuntu machine image to use for ec2 instance"
  type        = string
  default     = "ami-0914547665e6a707c" # Ubuntu 22.04 LTS // eu-north-1
}

variable "sg_id" {
  description = "sg ID for EC2"
  type = string
}
variable "PbSubnet" {
    description = "public subnet for ec2"
}

variable "lb_address" {
    description = "public dns name for load balancer"
}