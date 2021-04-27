FROM kong:1.5

USER root
RUN luarocks install kong-oidc
USER kong
EXPOSE 8000
EXPOSE 8001
