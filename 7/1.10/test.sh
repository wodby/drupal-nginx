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
nginxExec curl -s -I "localhost/authorize.php" | grep '302 Found'
nginxExec curl -s -I "localhost/cron.php" | grep '302 Found'
nginxExec curl -s -I "localhost/index.php" | grep '302 Found'
nginxExec curl -s -I "localhost/install.php" | grep '200 OK'
nginxExec curl -s -I "localhost/update.php" | grep '302 Found'
nginxExec curl -s -I "localhost/xmlrpc.php" | grep '302 Found'
nginxExec curl -s -I "localhost/non-existing.php" | grep '404 Not Found'
nginxExec curl -s -I "localhost/.htaccess" | grep '404 Not Found'
nginxExec curl -s -I "localhost/favicon.ico" | grep '200 OK'
nginxExec curl -s -I "localhost/robots.txt" | grep '200 OK'
nginxExec curl -s -I "localhost/misc/drupal.js" | grep '200 OK'
nginxExec curl -s -I "localhost/misc/druplicon.png" | grep '200 OK'

docker-compose -f test/docker-compose.yml down
