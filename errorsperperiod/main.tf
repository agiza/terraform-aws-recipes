resource "aws_cloudwatch_log_metric_filter" "default" {
  name           = "${var.bounded_context}_${var.error_count_threshold}_errors_per_${var.period_in_seconds}_seconds"
  pattern        = "[ERR]"
  log_group_name = "${var.log_group_name}"

  metric_transformation {
    name      = "EventCount"
    namespace = "${var.bounded_context}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "default" {
  alarm_name                = "${var.bounded_context}_${var.error_count_threshold}_errors_per_${var.period_in_seconds}_seconds_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.default.name}"
  namespace                 = "${var.bounded_context}"
  period                    = "${var.period_in_seconds}"
  statistic                 = "Sum"
  threshold                 = "${var.error_count_threshold}"
  alarm_description         = "[Severity:High][Stream:${var.stream_tag}][Service:${var.bounded_context}][DataCentre:${var.datacenter}][Environment:${var.environment}]"
  insufficient_data_actions = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
  ok_actions                = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
  alarm_actions             = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
}
