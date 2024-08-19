#these are the variables in order to maintain modular code.

variable "sg_id" {
  description = "SG ID for Application Load Balancer"
  type = string
}

variable "vpc_id" {
    description = "VPC ID for ALB"
    type = string
}

variable "PbSubnet" {
    description = "public subnet for ec2"
    type = string
}
variable "PbSubnet_2" {
    description = "second public subnet for alb"
    type = string
}

variable "instances" {
  description = "Instance ID for Target Group Attachment"
  type = string
}