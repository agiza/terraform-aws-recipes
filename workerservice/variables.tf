variable "region" {
  description = "The AWS region to create resources in."
}

variable "kms_region" {
} 

variable "datacenter" {
  description = "the datacenter where the ecs is hosted"
}

variable "environment" {
  description = "current hosting environment for applications"
  default = "Development"
}

variable "log_group_name" {
}

variable "log_stream_prefix" {
}

variable "ecr_image" {
  description = "the image url like so repository-url/image:tag"
}

variable "ecs_cluster_name" {
  description = "cluster name"
}

variable "ecs_service_name" {
  description = "name of the service"
}

variable "ecs_service_desired_count" {
	description = "the number of service you want to run in the cluster"
}