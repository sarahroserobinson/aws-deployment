resource "aws_vpc" "main_vpc" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.azs[count.index]
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

resource "aws_eip" "nat_gaterway_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gaterway_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*])
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_route_table_association" "nat_gateway" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.private_subnets[0].id
}

