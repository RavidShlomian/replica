output "vpc_id" {
    value = aws_vpc.task-vpc.id
}

output "PbSubnet" {
    value = aws_subnet.PbSubnet.id
} 

output "PbSubnet_2" {
    value = aws_subnet.PbSubnet_2.id
} 

output "PrSubnet" {
    value = aws_subnet.PrSubnet.id
}