# Creating elb for the web instances
resource "aws_elb" "web_elb" {
  name = "web-elb"
  #availability_zones = ["us-east-1a", "us-east-1b"]
  security_groups = [
    "${aws_security_group.ELB_SG.id}"
  ]
  
  # subnets = [
  #   var.subnet1_cidr, var.subnet2_cidr
  # ]
  
  instances = [aws_instance.subnet01-webservers[0].id, 
    aws_instance.subnet01-webservers[1].id, 
    aws_instance.subnet02-webservers[0].id,
    aws_instance.subnet02-webservers[1].id
  ]

  subnets = [
    "${aws_subnet.terraform_public_subnet01.id}",
    "${aws_subnet.terraform_public_subnet02.id}"
  ]
  
  # public_subnet_az1_id = aws_subnet.terraform_public_subnet01.id
  # public_subnet_az2_id = aws_subnet.terraform_public_subnet02.id
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }

}

# resource "aws_lb_target_group_attachment" "web" {
#   target_group_arn = aws_lb_target_group.alb-web.arn
#   target_id        = aws_lb_target_group.alb-web.id
#   #availability_zone = ["us-east-1a", "us-east-1b"]
#   port             = 80
# }

# resource "aws_lb_target_group" "alb-web" {
#   name        = "web-lb-alb-tg"
#   target_type = "alb"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = aws_vpc.Terra-vpc.id

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     interval            = 30
#     #target              = "HTTP:80/"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# create a listener on port 80 with redirect action
#   resource "aws_lb_listener" "web_alb_http_listener" {
#   load_balancer_arn = aws_elb.web_elb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

#    # cfeate a listener on port 443 with forward action
#   resource "aws_lb_listener" "web_alb_https_listener" {
#   load_balancer_arn = aws_elb.web_elb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-web.arn
#   }
# }



# creating elb for the d instances
resource "aws_elb" "database_elb" {
  name = "database-elb"
  #availability_zones = ["us-east-1c", "us-east-1d"]
  security_groups = [
    "${aws_security_group.database_security_group.id}"
  ]

  # subnets = [
  #   var.subnet3_cidr, var.subnet4_cidr
  # ]
  instances = [aws_instance.database01.id, aws_instance.database02.id]

  subnets = [
    "${aws_subnet.terraform_private_subnet01.id}",
    "${aws_subnet.terraform_private_subnet02.id}"
  ]
  
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }

}

# resource "aws_lb_target_group_attachment" "db" {
#   target_group_arn = aws_lb_target_group.alb-db.arn
#   target_id        = aws_lb_target_group.alb-db.id
#   #availability_zone = ["us-east-1c", "us-east-1d"]
#   port             = 80
# }

# resource "aws_lb_target_group" "alb-db" {
#   name        = "db-lb-alb-tg"
#   target_type = "alb"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.Terra-vpc.id

#   health_check {
#     enabled = true
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     interval            = 30
#     #target              = "HTTP:80/"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

   
#    # create a listener on port 80 with redirect action
#   resource "aws_lb_listener" "db_alb_http_listener" {
#   load_balancer_arn = aws_elb.database_elb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

#    # cfeate a listener on port 443 with forward action
#   resource "aws_lb_listener" "db_alb_https_listener" {
#   load_balancer_arn = aws_elb.database_elb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-db.arn
#   }
# }




# # Defining an Elastic Load Balancer
# resource "aws_elb" "terra-elb" {
#   name = "terra-elb"
#   #availability_zones = ["${var.azs}"]
#   subnets = [aws_subnet.public[0].id, aws_subnet.public[1].id, ] #aws_subnet.public.*.id  
#   #[for subnet in aws_subnet.public : subnet.id] not sure how to include this. Only one subnet per AZ can be used

#   security_groups = ["${aws_security_group.webservers.id}"]

#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:80/index.html"
#     interval            = 30
#   }

#   instances = [aws_instance.webservers[0].id, aws_instance.webservers[1].id, aws_instance.webservers[2].id, aws_instance.webservers[3].id]

#   cross_zone_load_balancing   = true
#   idle_timeout                = 100
#   connection_draining         = true
#   connection_draining_timeout = 300

#   tags = {
#     Name = "terraform-elb"
#   }
# }

# # output "elb-dns-name" {
# #   value = aws_elb.terra-elb.dns_name
# # }