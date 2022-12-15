resource "aws_lb" "app" {
  name               = "main-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_security_group.this_security_group_id]

  #enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances-lb.arn
  }
}

resource "aws_lb_target_group" "instances-lb" {
  name     = "tg-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

   depends_on = [
    aws_lb.app
  ]
}

resource "aws_lb_target_group_attachment" "instances-lb-attach" {
  count            = length(module.ec2_instances.instance_ids)
  target_group_arn = aws_lb_target_group.instances-lb.arn
  target_id        = module.ec2_instances.instance_ids[count.index]
  port             = 80
}
