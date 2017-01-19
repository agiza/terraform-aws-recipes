provider "aws" {
  region = "${var.region}"
}

resource "aws_alb" "default" {
  name            = "${var.alb_name}-alb"
  internal        = "${var.alb_is_internal}"
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${split(",", var.alb_subnets)}"]

  tags {
    Stream = "${var.stream_tag}"
  }
}

resource "aws_alb_target_group" "default" {
  name     = "${var.alb_name}-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  
  health_check {
    healthy_threshold = 5 /*Number of consecutive health check successes before declaring an EC2 instance healthy.*/
    unhealthy_threshold = 3 /*Number of consecutive health check failures before declaring an EC2 instance unhealthy.*/
    timeout = 3
    path = "/${var.healthcheck_page_name}"
    interval = 30
  }
}

resource "aws_alb_listener" "default_https" {
  load_balancer_arn = "${aws_alb.default.id}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.alb_ssl_certificate_id}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.default.id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "health-check" {
  alarm_name          = "${var.alb_name}-health-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Minimum"
  threshold           = "1"

  alarm_description         = "[[Standard format defined by Anton]]"
  ok_actions                = ["${var.eagle_eye_dashboard}", "arn:aws:sns:ap-southeast-2:047651431481:Mattb"]
  insufficient_data_actions = ["${var.eagle_eye_dashboard}", "arn:aws:sns:ap-southeast-2:047651431481:Mattb"]
  alarm_actions             = ["${var.eagle_eye_dashboard}", "arn:aws:sns:ap-southeast-2:047651431481:Mattb"]

  dimensions {
    LoadBalancer = "${aws_alb.default.arn_suffix}"
    TargetGroup  = "${aws_alb_target_group.default.arn_suffix}"
  }
}
