# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_range
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    var.common_tags,
    var.vpc_tags,
    { Name = local.name }
  )
}

# IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    { Name = local.name }
  )
}

###    Private subnets,Private Route table,Subents Association and Routes   ###
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = local.azs[count.index]
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    var.public_subnet_tags,
    { Name = "${local.name}-public-${local.azs[count.index]}" }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_rtg_tags,
    { Name = "${local.name}-public" }
  )
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

###    Private subnets,Private Route table,Subents Association and Routes   ###
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  availability_zone = local.azs[count.index]
  cidr_block        = var.private_subnet_cidrs[count.index]

  tags = merge(
    var.common_tags,
    var.private_subnet_tags,
    { Name = "${local.name}-private-${local.azs[count.index]}" }
  )
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_rtg_tags,
    { Name = "${local.name}-private" }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

# resource "aws_route" "private" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.example.id
# }
###    DB subnets,Private Route table,Subents Association and Routes   ###
resource "aws_subnet" "db" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  availability_zone = local.azs[count.index]
  cidr_block        = var.db_subnet_cidrs[count.index]

  tags = merge(
    var.common_tags,
    var.db_subnet_tags,
    { Name = "${local.name}-db-${local.azs[count.index]}" }
  )
}
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.db_rtg_tags,
    { Name = "${local.name}-db" }
  )
}
resource "aws_route_table_association" "db" {
  count          = length(var.db_subnet_cidrs)
  subnet_id      = element(aws_subnet.db[*].id, count.index)
  route_table_id = aws_route_table.db.id
}
# resource "aws_route" "db" {
#   route_table_id         = aws_route_table.db.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.example.id
# }

resource "aws_eip" "eip" {
  count  = var.nat_required ? 1 : 0
  domain = "vpc"
  tags = merge(
    var.common_tags,
    var.eip_tags,
    { Name = local.name }
  )
}

resource "aws_nat_gateway" "example" {
  count         = var.nat_required ? 1 : 0
  allocation_id = var.nat_required ? aws_eip.eip[0].id : null
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_tags,
    { Name = local.name }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

### VPC peering ############

resource "aws_vpc_peering_connection" "expense" {
  count       = var.peering_required ? 1 : 0
  vpc_id      = aws_vpc.main.id
  peer_vpc_id = var.acceptor_vpc_id == "" ? data.aws_vpc.default.id : var.acceptor_vpc_id
  auto_accept = var.acceptor_vpc_id == "" ? true : false # in the same account
  tags = merge(
    var.common_tags,
    var.peering_tags,
    { Name = local.name }
  )
}

resource "aws_route" "public_peering" {
  count                     = var.peering_required && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.expense[0].id
}

resource "aws_route" "private_peering" {
  count                     = var.peering_required && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.expense[0].id
}

resource "aws_route" "db_peering" {
  count                     = var.peering_required && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.db.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.expense[0].id
}

resource "aws_db_subnet_group" "default" {
  name       = local.name
  subnet_ids = aws_subnet.db[*].id

  tags = merge(
    var.common_tags,
    var.db_group_tags,
    { Name = local.name }
  )
}

