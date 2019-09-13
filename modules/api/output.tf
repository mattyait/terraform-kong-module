output "service_ids_out" {
  value = "${kong_service.service.*.id}"
}

# output "route_id_out" {
#   value = "${kong_service.api_route.id}"
# }

