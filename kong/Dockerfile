FROM kong:2.4.0-centos

LABEL description="Centos 7 + Kong 2.4.0 + kong-oidc plugin"

RUN yum install -y git unzip && yum clean all

RUN luarocks install kong-oidc

EXPOSE 8000
EXPOSE 8001
