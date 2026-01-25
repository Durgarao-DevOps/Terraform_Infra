resource "aws_subnet" "public" {
    for_each = var.public_subnets
    vpc_id            = aws_vpc.this.id
    cidr_block        = each.value.cidr
    availability_zone = each.value.az
    map_public_ip_on_launch = true
    tags = merge(var.tags, { Name = "${var.name}-public-${each.key}" })
  
}

resource "aws_subnet" "private" {
  for_each = var.private_app_subnets
  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr
    availability_zone = each.value.az
    tags = merge(var.tags, { Name = "${var.name}-private-app-${each.key}" })
}

resource "aws_subnet" "private_database" {
  for_each = var.private_database_subnets
  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr
  availability_zone =  each.value.az
  tags = merge(var.tags, { Name = "${var.name}-private-database-${each.key}" })   
}