#========KONG API Variables====
variable "kong-api-create-enable" {
  default = "true"
}

variable "kong-services-list" {}
variable "kong_admin_uri" {}
variable "kong_service_port" { default = 80 }
