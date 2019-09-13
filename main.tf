provider "kong" {
  kong_admin_uri = "${var.kong_admin_uri}"
}

module "kong" {
  source             = "modules/api"
  enable             = "${var.kong-api-create-enable}"
  kong-services-list = "${var.kong-services-list}"
}
