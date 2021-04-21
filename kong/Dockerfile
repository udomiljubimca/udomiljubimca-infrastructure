FROM kong:2.4.0-centos

LABEL description="Centos 7 + Kong 2.4.0 + kong-oidc plugin"
USER root
RUN luarocks install kong-oidc
USER kong
EXPOSE 8000
EXPOSE 8001
