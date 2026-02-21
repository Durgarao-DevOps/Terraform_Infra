resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

    tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table" "private_app" {
    for_each = aws_nat_gateway.this
    vpc_id = aws_vpc.this.id
    route {
      cidr_block = "0.0.0.0/0"
    nat_gateway_id = each.value.id
    }
    tags = merge(var.tags, { Name = "${var.name}-private-app-rt-${each.key}" }) 
}

resource "aws_route_table_association" "private_app" {
    for_each = aws_subnet.private
    subnet_id = each.value.id
    route_table_id = aws_route_table.private_app[each.key].id
  
}

resource "aws_route_table" "private_database" {
    vpc_id = aws_vpc.this.id
    tags = merge(var.tags, { Name = "${var.name}-private-database-rt" })
  
}

resource "aws_route_table_association" "private_database" {
  for_each       = aws_subnet.private_database
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_database.id
}