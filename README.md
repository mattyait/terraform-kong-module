# terraform-kong-module
kong api gateway module to create API definitions
Tested with kong provider 5.0.0 version


# Testing aginst the kong
Running  postgres database

    docker run -d --name kong-database \
                -p 5432:5432 \
                -e "POSTGRES_USER=kong" \
                -e "POSTGRES_DB=kong" \
                postgres:9.6

Prepare your database

    docker run --rm \
        --link kong-database:kong-database \
        -e "KONG_DATABASE=postgres" \
        -e "KONG_PG_HOST=kong-database" \
        -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
        kong kong migrations bootstrap

Start the Kong

    docker run -d --name kong \
        --link kong-database:kong-database \
        -e "KONG_DATABASE=postgres" \
        -e "KONG_PG_HOST=kong-database" \
        -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
        -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
        -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
        -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
        -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
        -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
        -p 8000:8000 \
        -p 8443:8443 \
        -p 8001:8001 \
        -p 8444:8444 \
        kong


> Kong Admin URL: http://localhost:8001/

> Kong API Gateway URL: http://localhost:8000/


mkdir -p ~/.terraform.d/plugins
cp ../kong-plugin/terraform-provider-kong_v5.0.0 ~/.terraform.d/plugins

#Usage

    module "kong-services" {
      source                 = "mattyait/module/kong"
      version                = "0.1.0"
      kong-api-create-enable = "true"
      kong_admin_uri         = "http://10.0.5.114:8001/"

      kong-services-list = [
        {
          service_name     = "findByStatus"
          service_protocol = "https"
          service_host     = "petstore.swagger.io"
          service_path     = "/"

          route_name      = "findByStatus-route"
          route_protocols = ["http", "https"]
          route_methods   = ["GET"]
          route_hosts     = ["localhost:8000"]
          route_paths     = ["/pet/findByStatus"]
        },
      ]
    }
