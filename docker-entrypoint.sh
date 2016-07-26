#!/bin/sh

set -eo pipefail

sed -i 's/UPSTREAM_NAME/'"${NGINX_UPSTREAM_NAME}"'/' /etc/nginx/nginx.conf

if [ -z "$DRUPAL_VERSION" ]; then
    DRUPAL_VERSION=8
fi

if [ ! "$(ls -A /etc/nginx/conf.d)" ]; then
    cp /opt/drupal${DRUPAL_VERSION}.conf /etc/nginx/conf.d/
fi

exec nginx -g "daemon off;"
