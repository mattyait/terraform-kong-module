variable enable {
  default = "true"
}

variable service_retries {
  default = "5"
}

variable connect_timeout {
  default = "1000"
}

variable write_timeout {
  default = "2000"
}

variable read_timeout {
  default = "3000"
}

variable route_strip_path {
  type    = bool
  default = false
}

variable route_preserve_host {
  type    = bool
  default = false
}

variable route_regex_priority {
  default = "0"
}

variable "kong-services-list" {
  description = "List of services want to create"
  type        = list
  default     = []
}
