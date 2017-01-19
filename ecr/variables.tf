variable "region" {  
}

variable "account_ids" {
  default = "\"arn:aws:iam::342212725307:root\",\"arn:aws:iam::047651431481:root\",\"arn:aws:iam::824362207773:root\""
}

variable "ecr_repo_name" {
  description = "ecr repo name"
}
