#Creating VPC
resource "aws_vpc" "Terra-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "Terra-vpc"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "Terraform-IGW" {
  vpc_id = aws_vpc.Terra-vpc.id
}

# Creating public subnet in region AZ1
resource "aws_subnet" "terraform_public_subnet01" {
  vpc_id                  = aws_vpc.Terra-vpc.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Terraform-public-subnet01"
  }
}

# Creating public subnet in AZ2
resource "aws_subnet" "terraform_public_subnet02" {
  vpc_id                  = aws_vpc.Terra-vpc.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "Terraform-public-subnet02"
  }
}

# # Creating private subnet in AZ3
resource "aws_subnet" "terraform_private_subnet01" {
  vpc_id                  = aws_vpc.Terra-vpc.id
  cidr_block              = var.subnet3_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "Terraform-private-subnet01"
  }
}

# Creating private subnet in AZ2
resource "aws_subnet" "terraform_private_subnet02" {
  vpc_id                  = aws_vpc.Terra-vpc.id
  cidr_block              = var.subnet4_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1d"

  tags = {
    Name = "Terraform-private-subnet02"
  }
}


#Creating Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.Terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terraform-IGW.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.Terraform-IGW.id
  }

  tags = {
    Name = "Route to internet"
  }
}

resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.terraform_public_subnet01.id
  route_table_id = aws_route_table.route.id
}

resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.terraform_public_subnet02.id
  route_table_id = aws_route_table.route.id
}

resource "aws_route_table_association" "rt3" {
  subnet_id      = aws_subnet.terraform_private_subnet01.id
  route_table_id = aws_route_table.route.id
}

resource "aws_route_table_association" "rt4" {
  subnet_id      = aws_subnet.terraform_private_subnet02.id
  route_table_id = aws_route_table.route.id
}








# # Defining VPC
# resource "aws_vpc" "terra_vpc" {
#   cidr_block = var.vpc_cidr

#   tags = {
#     Name = "TerraVPC"
#   }

# }

# # Defining Internet Gateway
# resource "aws_internet_gateway" "terra_igw" {
#   vpc_id = aws_vpc.terra_vpc.id

#   tags = {
#     Name = "main"
#   }
# }

# # Defining Public Subnets
# resource "aws_subnet" "public" {
#   count                   = length(var.public_subnets_cidr)
#   vpc_id                  = aws_vpc.terra_vpc.id
#   cidr_block              = element(var.public_subnets_cidr, count.index)
#   availability_zone       = element(var.azs, count.index)
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "Public-Subnet-${count.index + 1}"
#   }
# }


# # Defining Private Subnets
# resource "aws_subnet" "private" {
#   count                   = length(var.private_subnets_cidr)
#   vpc_id                  = aws_vpc.terra_vpc.id
#   cidr_block              = element(var.private_subnets_cidr, count.index)
#   availability_zone       = element(var.azs, count.index)
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "Private-Subnet-${count.index + 1}"
#   }
# }

# Route table: attach Internet Gateway 
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.terra_vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.terra_igw.id
#   }

#   tags = {
#     Name = "PublicRouteTable"
#   }
# }


# Defining Route table association with public subnets
# resource "aws_route_table_association" "a" {
#   count          = length(var.public_subnets_cidr)
#   subnet_id      = element(aws_subnet.public.*.id, count.index)
#   route_table_id = aws_route_table.public_rt.id
# }

