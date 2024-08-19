
#Creating the VPC resource block
resource "aws_vpc" "task-vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Moveo-VPC"
    }
}

#Creating a public subnet for the bastion instance
resource "aws_subnet" "PbSubnet"{
    vpc_id = aws_vpc.task-vpc.id
    availability_zone = "eu-north-1a"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "moveo-public-subnet"
    }
}
#Creating a second public subnet for the load balancer to spread traffic.
resource "aws_subnet" "PbSubnet_2"{
    vpc_id = aws_vpc.task-vpc.id
    availability_zone = "eu-north-1b"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "moveo-public-subnet-lb"
    }
}
#Creating a ptivate subnet - need to make sure that subnets wont overlap. also for vpc peering if there will be a future need.
resource "aws_subnet" "PrSubnet"{
    vpc_id = aws_vpc.task-vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "moveo-private-subnet"
    }
}


#Creating internet gateway for outside internet access for the public subnet. 
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.task-vpc.id
        tags = {
        Name = "moveo-igw"
    }
}

#Creating route table for public subnet. In addition, in the route table be dafault there is a "local route" for internal communication inside the vpc.
resource "aws_route_table" "public_route_table"{
    vpc_id = aws_vpc.task-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    
    tags = {
        Name = "moveo-public-route_table"
    }
}

# Creating an elastic ip for nat communication 
resource "aws_eip" "nat" {
  domain = "vpc"
}

#Creating the NAT gateway for outside world access for the private instance
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.PbSubnet.id

  tags = {
    Name = "nat-gateway"
  }
}

#Creating route table for private subnet
resource "aws_route_table" "private_route_table"{
    vpc_id = aws_vpc.task-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    
    tags = {
        Name = "moveo-private-route_table"
    }
}

#Creating link between public subnet and route table
resource "aws_route_table_association" "public_route_table_Association"{
    subnet_id = aws_subnet.PbSubnet.id
    route_table_id = aws_route_table.public_route_table.id
}

#Creating link between private subnet and route table
resource "aws_route_table_association" "private_route_table_Association"{
    subnet_id = aws_subnet.PrSubnet.id
    route_table_id = aws_route_table.private_route_table.id
}