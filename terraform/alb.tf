resource "aws_lb" "test-lb" {
  name               = "${terraform.workspace}-flask-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  tags = {
    Name        = "${var.app_name}-load-balancer"
    Environment = var.app_environment
  }
  security_groups = [aws_security_group.lb.id]
}

resource "aws_security_group" "lb" {
  name   = "${terraform.workspace}-asg-lb"
  vpc_id = aws_vpc.aws-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${terraform.workspace}-asg"
    Environment = var.app_environment
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${terraform.workspace}-flask-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.aws-vpc.id

  health_check {
    path = "/"
    #  healthy_threshold   = 2
    #  unhealthy_threshold = 5
    #  timeout             = 60
    interval = 100
    #  matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}