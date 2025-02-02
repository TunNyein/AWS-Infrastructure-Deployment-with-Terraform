resource "aws_vpc" "aws_vpcs" {
  for_each = local.aws_vpcs
  cidr_block = each.value.vpc_cidr_block
  tags = each.value.tags
    
}


resource "aws_subnet" "aws_subnets" {
  for_each = local.aws_subnets
  vpc_id            = aws_vpc.aws_vpcs[each.value.vpc_key].id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }

}

resource "aws_route_table" "aws_rtbs" {

  for_each = local.aws_rtbs
  vpc_id   = aws_vpc.aws_vpcs[each.value.vpc_key].id


  tags = {
    Name = each.key
  }
}

resource "aws_route_table_association" "rtb_associations" {
  for_each = local.rtb_associations
  subnet_id      = aws_subnet.aws_subnets[each.value.subnet_id].id
  route_table_id = aws_route_table.aws_rtbs[each.value.rtb_id].id
  
}

resource "aws_internet_gateway" "gw" {
  for_each = local.igws

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  
  for_each = local.igw_attach

  internet_gateway_id = aws_internet_gateway.gw[each.value.igw_id].id
  vpc_id              = aws_vpc.aws_vpcs[each.value.vpc_key].id
}

resource "aws_route" "route_igw" {
  for_each = local.route_igw
  route_table_id            = aws_route_table.aws_rtbs[each.value.rtb_id].id
  destination_cidr_block    = each.value.des_cidr_block
  gateway_id = aws_internet_gateway.gw[each.value.igw_id].id
}



resource "tls_private_key" "ssh" {
  for_each = local.sshs
  algorithm = each.value.algorithm
  rsa_bits  = each.value.rsa_bits
  
}



resource "aws_key_pair" "this" {
  for_each = local.key_pairs
  key_name   = each.value.key_name
  public_key = tls_private_key.ssh[each.value.public_key].public_key_openssh 
}

resource "local_file" "private" {
  for_each = local.private_keys
  content  = tls_private_key.ssh[each.value.content].private_key_openssh
  filename = "${path.module}/ssh-private-keys/${each.value.filename}.pem"

  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/ssh-private-keys/${each.value.filename}.pem"
    
  }
}




resource "aws_instance" "instances" {

  for_each = local.instances_id
  ami                     = each.value.ami
  instance_type           = each.value.instance_type
  subnet_id               = aws_subnet.aws_subnets[each.value.subnet_id].id
  key_name                = each.value.key_name
  associate_public_ip_address = true
  
  tags = {
    Name = each.key
  }
}