#!/bin/bash
docker-compose -f docker-compose-kong.yaml up -d kong-db
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations bootstrap
docker-compose -f docker-compose-kong.yaml run --rm kong kong migrations up
docker-compose -f docker-compose-kong.yaml up -d kong

# check if it's true
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc

#
curl -s -X POST http://localhost:8001/services \
    -d name=register-api \
    -d url=http://register-api:8080 \
    | python3 -mjson.tool
# Now take ID! like: 16f5ba59-2a2f-4378-bd7c-f3df1e6475e3

curl -s -X POST http://localhost:8001/routes \
    -d service.id=16f5ba59-2a2f-4378-bd7c-f3df1e6475e3 \
    -d paths[]=/ \
    | python3 -mjson.tool

#and you will get ID like: aca8e64c-c6bd-4455-9712-b4ca6349079d

# If you want to relete:
#curl -X DELETE "http://localhost:8001/services/register-api/routes/55e9cc40-2a6b-4ba0-bc08-42dd68134f39"

curl -s -X POST http://localhost:8001/plugins \
  -d name=oidc \
  -d config.client_id=kong \
  -d config.client_secret=8003ba0b-073a-4ccb-a4d4-c024064c2fac \
  -d config.discovery=http://keycloak:8080/auth/realms/udomiljubimcadev/.well-known/openid-configuration \
  | python3 -mjson.tool