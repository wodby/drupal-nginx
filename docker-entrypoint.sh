#!/bin/sh

set -eo pipefail

cp /opt/drupal.conf /etc/nginx/conf.d/

exec nginx -g "daemon off;"
