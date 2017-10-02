#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

sudo fix-permissions.sh www-data www-data "${WODBY_DIR_FILES}" "${HTML_DIR}"

gotpl /etc/gotpl/drupal.conf.tpl > /etc/nginx/conf.d/drupal.conf
gotpl /etc/gotpl/fastcgi_params.tpl > /etc/nginx/fastcgi_params