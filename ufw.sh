#!/bin/bash

ufw allow ssh
ufw allow 22
ufw allow http
ufw allow https
ufw allow 80
ufw allow 443
ufw allow from any to 10.123.176.2 port 8080
ufw allow from 104.248.249.114 to any port 