# elb name
output "web-elb-dns-id" {
  value = aws_elb.web_elb.arn
}

output "database_elb-dns-id" {
  value = aws_elb.database_elb.arn
}

# web server ips
output "subnet01-webservers-public_ip" {
  value = aws_instance.subnet01-webservers.*.public_ip
}

output "subnet02-webservers-public_ip" {
  value = aws_instance.subnet02-webservers.*.public_ip
}

output "dbinstance01-public_ip" {
  value = aws_instance.database01.public_ip
}

output "dbinstance02-public_ip" {
  value = aws_instance.database02.public_ip
}







# #### Defining outputs from resources
# # aws_vpc" "terra_vpc
# output "vpc_id" {
#   value = aws_vpc.terra_vpc.id
# }

# # elb name
# output "elb-dns-id" {
#   value = aws_elb.terra-elb.arn
# }

# # web server ips
# output "ip" {
#   value = aws_instance.webservers.*.public_ip
# }


# output "database-instance" {
#   value     = aws_db_instance.db_instance
#   sensitive = true
# }