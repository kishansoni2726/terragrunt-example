
resource "aws_lb" "alb" {
    name                              = "${var.env}-Public-ALB"
    internal                          = false
    load_balancer_type                = "application"
    security_groups                   = [aws_security_group.web_server_sg.id ]
    subnets                           = [for subnet in aws_subnet.public_subnets : subnet.id]
    tags = {
        Createdwith                   = "Terraform"
    }
}

resource "aws_lb_target_group" "lb_target_group" {
    name                              = "${var.env}-Target-Group"
    port                              = 80
    protocol                          = "HTTP"
    vpc_id                            = aws_vpc.main.id
    target_type                       = "instance"
    tags = {
        Createdwith                   = "Terraform"
    } 
}

resource "aws_autoscaling_attachment" "asg_to_target_group" {
    autoscaling_group_name            = aws_autoscaling_group.ec2_asg.name
    lb_target_group_arn               = aws_lb_target_group.lb_target_group.arn
}

resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn                 = aws_lb.alb.arn
    port                              = "80"
    protocol                          = "HTTP"
    default_action {
        type                          = "forward"
        target_group_arn              = aws_lb_target_group.lb_target_group.arn
    }
}
