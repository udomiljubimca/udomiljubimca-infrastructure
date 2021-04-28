#!/bin/bash
docker-compose -f docker-compose-kong.yaml up -d kong-db
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations bootstrap
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations up
docker-compose -f docker-compose-kong.yaml up -d kong
docker-compose -f docker-compose-kong.yaml up -d konga-gui

#
curl -s -X POST http://localhost:8001/services \
    -d name=register-api \
    -d url=http://register-api:8080 \
    | python3 -mjson.tool
# Now take ID! like: 86089e8b-297c-4065-85dc-ba97224614a0

curl -s -X POST http://localhost:8001/routes \
    -d service.id=86089e8b-297c-4065-85dc-ba97224614a0 \
    -d paths[]=/ \
    | python3 -mjson.tool

curl -s -X POST http://localhost:8001/services/86089e8b-297c-4065-85dc-ba97224614a0/plugins \
  -d name=jwt-keycloak \
  -d config.allowed_iss=http://dev.udomi-ljubimca.com:8080/auth/realms/udomiljubimcadev \
  | python3 -mjson.tool


curl -d "client_secret=8003ba0b-073a-4ccb-a4d4-c024064c2fac" -d "client_id=app" -d "username=ognjenit" -d "password=Test123" -d "grant_type=password" "http://dev.udomi-ljubimca.com:8080/auth/realms/udomiljubimcadev/protocol/openid-connect/token"
