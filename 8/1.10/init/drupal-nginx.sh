#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

chown www-data:www-data "${WODBY_DIR_FILES}"

if [ ! -e /etc/nginx/conf.d/drupal.conf ]; then
    gotpl /etc/gotpl/drupal.conf.tpl > /etc/nginx/conf.d/drupal.conf
fi