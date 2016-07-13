#!/bin/sh

set -eo pipefail

if [ -z "$NGINX_APP" ]; then
    NGINX_APP="drupal8"
fi

if [ ! "$(ls -A /etc/nginx/conf.d)" ]; then
    cp /opt/${NGINX_APP}.conf /etc/nginx/conf.d/
fi

exec nginx -g "daemon off;"
