resource "kong_service" "service" {
  count           = "${var.enable == "true" ? length(var.kong-services-list) : 0}"
  name            = "${var.kong-services-list[count.index]["service_name"]}"
  protocol        = "${var.kong-services-list[count.index]["service_protocol"]}"
  host            = "${var.kong-services-list[count.index]["service_host"]}"
  path            = "${var.kong-services-list[count.index]["service_path"]}"
  port            = "${var.kong_service_port}"
  retries         = "${var.service_retries}"
  connect_timeout = "${var.connect_timeout}"
  write_timeout   = "${var.write_timeout}"
  read_timeout    = "${var.read_timeout}"
}

resource "kong_route" "api_route" {
  count     = "${var.enable == "true" ? length(var.kong-services-list) : 0}"
  name      = "${var.kong-services-list[count.index]["route_name"]}"
  protocols = "${var.kong-services-list[count.index]["route_protocols"]}"
  methods   = "${var.kong-services-list[count.index]["route_methods"]}"
  hosts     = "${var.kong-services-list[count.index]["route_hosts"]}"
  paths     = "${var.kong-services-list[count.index]["route_paths"]}"

  strip_path     = "${var.route_strip_path}"
  preserve_host  = "${var.route_preserve_host}"
  regex_priority = "${var.route_regex_priority}"
  service_id     = "${kong_service.service[count.index].id}"
}
