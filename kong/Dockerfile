FROM kong:1.5

USER root
RUN apk add git
RUN luarocks install kong-plugin-jwt-keycloak && \
    luarocks pack kong-plugin-jwt-keycloak
RUN luarocks install request-transformer && \
    luarocks pack request-transformer
USER kong
EXPOSE 8000
EXPOSE 8001
