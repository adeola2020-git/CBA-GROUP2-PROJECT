resource "aws_instance" "subnet01-webservers" {
  count = var.public_subnet01_web_server_count
  #count           = length(var.public_subnets_cidr)
  subnet_id       = aws_subnet.terraform_public_subnet01.id
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.keyname
  security_groups = ["${aws_security_group.ELB_SG.id}"]

  tags = {
    Name = "subnet01-web-${count.index}"
  }
}

resource "aws_instance" "subnet02-webservers" {
  count = var.public_subnet02_web_server_count
  #count           = length(var.public_subnets_cidr)
  subnet_id       = aws_subnet.terraform_public_subnet02.id
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.keyname
  security_groups = ["${aws_security_group.ELB_SG.id}"]

  tags = {
    Name = "subnet02-web-${count.index}"
  }
}

resource "aws_instance" "database01" {
  #count           = length(var.public_subnets_cidr)
  subnet_id       = aws_subnet.terraform_private_subnet01.id
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.keyname
  security_groups = ["${aws_security_group.database_security_group.id}"]

  tags = {
    Name = "db-instance01"
  }
}


resource "aws_instance" "database02" {
  #count           = length(var.public_subnets_cidr)
  subnet_id       = aws_subnet.terraform_private_subnet02.id
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.keyname
  security_groups = ["${aws_security_group.database_security_group.id}"]

  tags = {
    Name = "db-instance02"
  }
}







# resource "aws_instance" "webservers" {
#   #count           = length(var.public_subnets_cidr)
#   subnet_id       = element(aws_subnet.public.*.id, count.index)
#   ami             = var.webservers_ami
#   instance_type   = var.instance_type
#   key_name        = var.keyname
#   security_groups = ["${aws_security_group.webservers.id}"]

#   tags = {
#     Name = "Web-Server-${count.index}"
#   }
# }





# output "ip" {
#   value = aws_instance.webservers.*.public_ip
# }

# output "webservers" {
#   value = "${aws_instance.webservers.*.public_ip}"
# }

