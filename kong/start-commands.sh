#!/bin/bash
docker-compose -f docker-compose-kong.yaml up -d kong-db
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations bootstrap
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations up
docker-compose -f docker-compose-kong.yaml up -d kong
docker-compose -f docker-compose-kong.yaml up -d konga-gui


# check if it's true
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc

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

#and you will get ID like: 240dae85-70ab-4332-9f19-a3334a9a793b

# If you want to relete:
#curl -X DELETE "http://localhost:8001/services/register-api/routes/55e9cc40-2a6b-4ba0-bc08-42dd68134f39"

curl -s -X POST http://localhost:8001/plugins \
  -d name=oidc \
  -d config.client_id=app \
  -d config.client_secret=8003ba0b-073a-4ccb-a4d4-c024064c2fac \
  -d config.ssl_verify=false \
  -d config.realm=udomiljubimcadev \
  -d config.introspection_endpoint=http://149.81.126.136:8080/auth/realms/udomiljubimcadev/protocol/openid-connect/token/introspect \
  -d config.discovery=http://149.81.126.136:8080/auth/realms/udomiljubimcadev/.well-known/openid-configuration \
  | python3 -mjson.tool