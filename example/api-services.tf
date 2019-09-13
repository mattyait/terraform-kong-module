terraform {
  required_version = ">= 0.12"

  required_providers {
    kong = "~> 5.0"
  }
}


module "kong-services" {
  #source                 = "mattyait/module/kong"
  #version                = "0.1.0"
  source                 = "../"
  kong-api-create-enable = "true"
  kong_admin_uri         = "http://10.1.1.57:8001/"

  kong-services-list = [
    {
      service_name     = "findByStatus"
      service_protocol = "https"
      service_host     = "petstore.swagger.io"
      service_path     = "/"

      route_name      = "findByStatus-route"
      route_protocols = ["http", "https"]
      route_methods   = ["GET"]
      route_hosts     = ["10.1.1.57:8000"]
      route_paths     = ["/pet/findByStatus"]
    },
  ]
}


# output "log" {
#   value = "${yamldecode(file("../../deployment/test.yml"))["a"]}"
# }
