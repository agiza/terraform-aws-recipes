variable "region" {
  description = "The AWS region to create resources in."
}

variable "vpc_id" {
  description = "The VPC"
}

variable "alb_name" {}

variable "alb_is_internal" {
  default     = "false"
  description = "internal or external alb for the web role, default is false."
}

variable "alb_subnets" {
  description = "Vpc subnets where the load balance for web service should be launched"
}

variable "alb_ssl_certificate_id" {}

variable "stream_tag" {}

variable "eagle_eye_sns_topic_arn" {
  default = "arn:aws:sns:ap-southeast-2:047651431481:EagleEye-Development-Alerts"
}
variable "team_sns_topic_arn" {}

variable "environment" {}
variable "datacenter" {}

