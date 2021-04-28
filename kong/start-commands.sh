#!/bin/bash

# First time install kong
docker-compose -f docker-compose-kong.yaml up -d kong-db
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations bootstrap
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations up
docker-compose -f docker-compose-kong.yaml up -d kong
docker-compose -f docker-compose-kong.yaml up -d konga-gui

########################################### EXAMPLE FOR REGISTER API ###########################################
# Create Service
curl -s -X POST http://localhost:8001/services \
    -d name=register-api \
    -d url=http://register-api:8080 \
    | python3 -mjson.tool
# Now take ID! like: 6339f5f9-344c-4675-9ac5-689b0ed63276

# Create route
curl -s -X POST http://localhost:8001/routes \
    -d service.id=6339f5f9-344c-4675-9ac5-689b0ed63276 \
    -d paths[]=/ \
    | python3 -mjson.tool

# Set plugin to service
# curl -s -X POST http://localhost:8001/services/6339f5f9-344c-4675-9ac5-689b0ed63276/plugins \
#   -d name=jwt-keycloak \
#   -d config.allowed_iss=http://dev.udomi-ljubimca.com:8080/auth/realms/udomiljubimcadev \
#   | python3 -mjson.tool


# GET TOKEN!
curl -d "client_secret=<>" -d "client_id=app" -d "username=ognjenit" -d "password=Test123" -d "grant_type=password" "http://dev.udomi-ljubimca.com:8080/auth/realms/udomiljubimcadev/protocol/openid-connect/token"
#################################################################################################################