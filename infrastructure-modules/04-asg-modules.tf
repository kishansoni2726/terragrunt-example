resource "aws_launch_configuration" "ec2_launch_config" {
    name                              = "${var.env}-Launch-config"
    image_id                          = data.aws_ami.ubuntu.id
    security_groups                   = [aws_security_group.web_server_sg.id]
    user_data                         = var.user_data
    instance_type                     = var.instance_type
    key_name                          = var.key_name
}

resource "aws_autoscaling_group" "ec2_asg" {
    name                              = "${var.env}-ASG"
    vpc_zone_identifier               = [for subnet in aws_subnet.public_subnets : subnet.id]
    launch_configuration              = aws_launch_configuration.ec2_launch_config.name
    desired_capacity                  = var.desired_capacity
    min_size                          = var.min_size
    max_size                          = var.max_size
    health_check_grace_period         = var.health_check_grace_period
    health_check_type                 = "EC2"
}
