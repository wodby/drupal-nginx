#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

nginxExec() {
    docker-compose -f test/docker-compose.yml exec --user=82 nginx "${@}"
}

docker-compose -f test/docker-compose.yml up -d

nginxExec make check-ready -f /usr/local/bin/actions.mk

nginxExec curl -s -I "localhost" | grep '302 Found'
nginxExec curl -s -I "localhost/core/authorize.php" | grep '500 Service unavailable'
nginxExec curl -s -I "localhost/core/install.php" | grep '200 OK'
nginxExec curl -s -I "localhost/core/modules/statistics/statistics.php" | grep '500 Service unavailable'
nginxExec curl -s -I "localhost/cron" | grep '200 OK'
nginxExec curl -s -I "localhost/index.php" | grep '302 Found'
nginxExec curl -s -I "localhost/update.php" | grep '500 Service unavailable'
nginxExec curl -s -I "localhost/non-existing.php" | grep '404 Not Found'
nginxExec curl -s -I "localhost/.htaccess" | grep '404 Not Found'
nginxExec curl -s -I "localhost/favicon.ico" | grep '200 OK'
nginxExec curl -s -I "localhost/robots.txt" | grep '200 OK'
nginxExec curl -s -I "localhost/core/misc/drupal.js" | grep '200 OK'
nginxExec curl -s -I "localhost/core/misc/druplicon.png" | grep '200 OK'

docker-compose -f test/docker-compose.yml down