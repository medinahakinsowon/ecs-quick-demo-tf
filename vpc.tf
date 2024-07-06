resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main_vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required", "opted-in"]
  }
}

locals {
  main_azs = [for az in data.aws_availability_zones.available.names : az if length(regexall("^[a-z]{2}-[a-z]+-[0-9]{1}[a-z]$", az)) > 0]
}

resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(local.main_azs, count.index % length(local.main_azs))

  tags = {
    Name = "main_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main_rt"
  }
}

resource "aws_route_table_association" "a" {
  count          = length(var.subnet_cidrs)
  subnet_id      = element(aws_subnet.subnet[*].id, count.index)
  route_table_id = aws_route_table.rt.id
}
