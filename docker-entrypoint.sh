#!/bin/sh

set -eo pipefail

# Set upstream name
sed -i 's/UPSTREAM_NAME/'"${NGINX_UPSTREAM_NAME}"'/' /etc/nginx/nginx.conf

# Ensure drupal version defined.
if [ -z "$DRUPAL_VERSION" ]; then
    DRUPAL_VERSION=8
fi

# Copy default nginx config.
if [ ! "$(ls -A /etc/nginx/conf.d)" ]; then
    cp /opt/drupal${DRUPAL_VERSION}.conf /etc/nginx/conf.d/
fi

# Ensure docroot defined.
if [ -n "$NGINX_DOCROOT" ]; then
    sed -i 's@root /var/www/html/;@'"root /var/www/html/${NGINX_DOCROOT};"'@' /etc/nginx/conf.d/*.conf
fi

exec nginx -g "daemon off;"
