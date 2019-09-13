variable environment {}
variable aws_region {}
variable aws_profile {}
variable dynamo_db_lock {}

#========KONG API Variables====
variable "kong-api-create-enable" {
  default = "true"
}

variable "kong-services-list" {}
variable "kong_admin_uri" {}
