#!/bin/bash

# First time install kong
docker-compose -f docker-compose-kong.yaml up -d kong-db
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations bootstrap
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations up
docker-compose -f docker-compose-kong.yaml up -d kong
docker-compose -f docker-compose-kong.yaml up -d konga-gui

########################################### EXAMPLE FOR REGISTER API ###########################################
# Create Service
curl -s -X POST http://10.123.176.2:8001/services \
    -d name=register-api-service \
    -d url=http://register-api:8080 \
    | python3 -mjson.tool
# Now take ID! like: 1be5b32b-b7c1-464e-a1b9-b6ab14074c53

# Create route
curl -s -X POST http://10.123.176.2:8001/routes \
    -d name=register-api-route \
    -d service.id=1be5b32b-b7c1-464e-a1b9-b6ab14074c53 \
    -d hosts[]=149.81.126.136 \
    -d hosts[]=10.123.176.2 \
    -d paths[]=/ \
    -d methods[]=GET \
    -d methods[]=POST \
    -d protocols[]=http \
    -d protocols[]=https \
    | python3 -mjson.tool

# Set plugin to service
# curl -s -X POST http://10.123.176.2:8001/services/1be5b32b-b7c1-464e-a1b9-b6ab14074c53/plugins \
#   -d name=jwt-keycloak \
#   -d config.allowed_iss=http://149.81.126.136:8080/auth/realms/udomiljubimcadev \
#   | python3 -mjson.tool


# GET TOKEN!
curl -d "client_secret=<>" -d "client_id=app" -d "username=ognjenit" -d "password=Test123" -d "grant_type=password" "http://149.81.126.136:8080/auth/realms/udomiljubimcadev/protocol/openid-connect/token"
#################################################################################################################