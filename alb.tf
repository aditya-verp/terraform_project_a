# Create ALB
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id]

  tags = {
    Name   = "Application Load Balancer forwards traffic to webserver"
    Partof = "TaskProject"
  }
}

# Create Target Group
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "web-tg"
  }
}

# Create Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Attach EC2 Instance to Target Group
resource "aws_lb_target_group_attachment" "web_tg_attachment" {
 target_group_arn = aws_lb_target_group.web_tg.arn
 target_id        = aws_instance.web_instance.id
 port             = 80
}


output "web_alb_id" {
  value = aws_lb.web_alb.dns_name
}
