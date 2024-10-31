#!/bin/bash
# Phase 1
docker-compose -f ./docker-compose-initiate.yml up -d gateway
docker-compose -f ./docker-compose-initiate.yml up certbot
docker-compose -f ./docker-compose-initiate.yml down

# some configurations for let's encrypt
curl -L --create-dirs -o  ./openmrs/gateway/etc/letsencrypt/options-ssl-nginx.conf https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf
openssl dhparam -out ./openmrs/gateway/etc/letsencrypt/ssl-dhparams.pem 2048

# Phase 2
crontab ./openmrs/gateway/crontab
docker compose up -d