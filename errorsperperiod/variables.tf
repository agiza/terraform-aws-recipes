variable "period_in_seconds" {
  description = "The period in seconds over which to evaluate how many errors have occurred."
}

variable "error_count_threshold" {
  description = "The threshold for the number of errors that will trigger an alarm."
}

variable "eagle_eye_sns_topic_arn" {
  description = "EagleEye dashboard SNS topic arn"
}

variable "team_sns_topic_arn" {
  description = "The teams SNS topic, e.g. email list"
}

variable "bounded_context" {}

variable "log_group_name" {}

variable "stream_tag" {}

variable "datacenter" {}

variable "environment" {}
