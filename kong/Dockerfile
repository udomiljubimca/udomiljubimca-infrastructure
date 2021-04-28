FROM kong:1.5

USER root
RUN apk add git
# RUN luarocks install kong-oidc
RUN luarocks install kong-plugin-jwt-keycloak && \
    luarocks pack kong-plugin-jwt-keycloak
USER kong
EXPOSE 8000
EXPOSE 8001
