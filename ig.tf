resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_route_table" "example_public_rt" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

#attchinf route table in subnets
resource "aws_route_table_association" "example_subnet_1_rt_assoc" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example_public_rt.id
}

resource "aws_route_table_association" "example_subnet_2_rt_assoc" {
  subnet_id      = aws_subnet.example_subnet_2.id
  route_table_id = aws_route_table.example_public_rt.id
}

