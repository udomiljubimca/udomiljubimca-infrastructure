#!/bin/bash
docker-compose up -d kong-db
docker-compose run --rm kong kong migrations bootstrap
docker-compose run --rm kong kong migrations up
docker-compose up -d kong

# check if it's true
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc

#
curl -s -X POST http://localhost:8001/services \
    -d name=register-api \
    -d url=http://register-api:8080 \
    | python3 -mjson.tool
# Now take ID! like: a42388a5-25ee-4297-9398-b4808b84ccef

curl -s -X DELETE http://localhost:8001/routes \
    -d service.id=a42388a5-25ee-4297-9398-b4808b84ccef \
    -d paths[]=/ \
    | python3 -mjson.tool

#and you will get ID like: 55e9cc40-2a6b-4ba0-bc08-42dd68134f39

# If you want to relete:
#curl -X DELETE "http://localhost:8001/services/register-api/routes/55e9cc40-2a6b-4ba0-bc08-42dd68134f39"