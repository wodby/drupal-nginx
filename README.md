# Nginx docker container image for Drupal

[![Build Status](https://travis-ci.org/wodby/drupal-nginx.svg?branch=master)](https://travis-ci.org/wodby/drupal-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

To get full docker-based local environment for Drupal see [Docker4Drupal](http://docker4drupal.org).

## Supported tags and respective `Dockerfile` links

- [`8-1.13-2.2.0`, `8-1.13`, `latest` (*8/1.13/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/8/1.13/Dockerfile)
- [`8-1.12-2.2.0`, `8-1.12`, (*8/1.12/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/8/1.12/Dockerfile)
- [`8-1.10-2.2.0`, `8-1.10`, (*8/1.10/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/8/1.10/Dockerfile)
- [`7-1.13-2.2.0`, `7-1.13`, (*7/1.13/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/7/1.13/Dockerfile)
- [`7-1.12-2.2.0`, `7-1.12`, (*7/1.12/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/7/1.12/Dockerfile)
- [`7-1.10-2.2.0`, `7-1.10`, (*7/1.10/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/7/1.10/Dockerfile)
- [`6-1.13-2.2.0`, `6-1.13`, (*6/1.13/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/6/1.13/Dockerfile)
- [`6-1.12-2.2.0`, `6-1.12`, (*6/1.12/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/6/1.12/Dockerfile)
- [`6-1.10-2.2.0`, `6-1.10`, (*6/1.10/Dockerfile*)](https://github.com/wodby/drupal-nginx/blob/master/6/1.10/Dockerfile)

## Environment variables available for customization

See at [wodby/nginx](https://github.com/wodby/nginx)

| Environment Variable | Type | Default Value | Description |
| -------------------- | -----| ------------- | ----------- |
| NGINX_SERVER_NAME                             | String | drupal                     | |
| NGINX_SERVER_ROOT                             | String | /var/www/html              | |
| NGINX_STATIC_CONTENT_EXPIRES                  | String | 30d                        | |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE          | String | max=3000 inactive=120s     | |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_VALID    | String | 45s                        | |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_MIN_USES | Int    | 2                          | |
| NGINX_DRUPAL_TRACK_UPLOADS                    | String | uploads 60s                | |
| NGINX_STATIC_CONTENT_ACCESS_LOG               | String | off                        | |
| NGINX_SERVER_EXTRA_CONF_FILEPATH              | String |                            | |
| NGINX_XMLRPC_SERVER_NAME                      | String |                            | |

## Using in production

Deploy docker-based infrastructure for Drupal to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
