resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    tags = {
      Name = var.vpc_name
    }
  
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    map_public_ip_on_launch = true 
    availability_zone = var.availability_zone[count.index]
    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    map_public_ip_on_launch = false 
    availability_zone = var.availability_zone[count.index]
  
  tags = {
    Name = "Private Subnet"
  }

}

resource "aws_internet_gateway" "myIGW" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "my Internet Gateway"
    }
}

# Add the default route to internet gateway
resource "aws_route_table" "myRouteTable" {
    vpc_id = aws_vpc.main.id

    route  {
        cidr_block = "0.0.0.0/0"  # Default route to internet
        gateway_id = aws_internet_gateway.myIGW.id
    }
    
    tags = {
    Name = "Public Route Table"
  }
}

#  Associate Route Table with Public Subnet
resource "aws_route_table_association" "routetb_pubassociat" {
    count          = length(var.public_subnet_cidr) 
    subnet_id =  aws_subnet.public[count.index].id
    route_table_id = aws_route_table.myRouteTable.id
  
}

