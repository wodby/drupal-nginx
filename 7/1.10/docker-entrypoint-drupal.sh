#!/usr/bin/env bash

set -e

if [[ -n $DEBUG ]]; then
  set -x
fi

gotpl /etc/gotpl/drupal.conf.tpl > /etc/nginx/conf.d/drupal.conf

exec /docker-entrypoint.sh "$@"
