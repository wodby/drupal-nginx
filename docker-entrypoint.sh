#!/bin/sh

set -eo pipefail

if [ -z "$APP_ENV_DRUPAL_VERSION" ]; then
    APP_ENV_DRUPAL_VERSION=8
fi

if [ ! "$(ls -A /etc/nginx/conf.d)" ]; then
    cp /opt/drupal${APP_ENV_DRUPAL_VERSION}.conf /etc/nginx/conf.d/
fi

exec nginx -g "daemon off;"
