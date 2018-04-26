# Nginx for Drupal Docker Container Image

[![Build Status](https://travis-ci.org/wodby/drupal-nginx.svg?branch=master)](https://travis-ci.org/wodby/drupal-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/drupal-nginx.svg)](https://microbadger.com/images/wodby/drupal-nginx)

## Docker Images

!!! For better reliability we release images with stability tags (`wodby/drupal-nginx:1.13-X.X.X`) which correspond to [git tags](https://github.com/wodby/drupal-nginx/releases). We **STRONGLY RECOMMEND** using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [wodby/php-nginx](https://github.com/wodby/php-nginx)
* [Travis CI builds](https://travis-ci.org/wodby/drupal-nginx) 
* [Docker Hub](https://hub.docker.com/r/wodby/drupal-nginx)

[_(Dockerfile)_]: https://github.com/wodby/drupal-nginx/tree/master/Dockerfile 

| Supported tags and respective `Dockerfile` links | Drupal | Nginx |
| ------------------------------------------------ | ------ | ----- |
| `8-1.14`, `8`, `latest` [_(Dockerfile)_]         | 8      | 1.14  |
| `7-1.14`, `7` [_(Dockerfile)_]                   | 7      | 1.14  |
| `6-1.14`, `6` [_(Dockerfile)_]                   | 6      | 1.14  |
| `8-1.13` [_(Dockerfile)_]                        | 8      | 1.13  |
| `7-1.13` [_(Dockerfile)_]                        | 7      | 1.13  |
| `6-1.13` [_(Dockerfile)_]                        | 6      | 1.13  |

## Environment Variables

See at [wodby/php-nginx](https://github.com/wodby/php-nginx)

| Variable                                        | Default Value            | Description                   |
| ----------------------------------------------- | ------------------------ | ----------------------------- |
| `NGINX_ALLOW_XML_ENDPOINTS`                     |                          |                               |
| `NGINX_BACKEND_HOST`                            |                          |                               |
| `NGINX_DRUPAL_HIDE_HEADERS`                     |                          |                               |
| `NGINX_DRUPAL_TRACK_UPLOADS`                    | `uploads 60s`            |                               |
| `NGINX_DRUPAL_FILE_PROXY_URL`                   |                          | e.g. `http://dev.example.com` |
| `NGINX_SERVER_EXTRA_CONF_FILEPATH`              |                          |                               |
| `NGINX_SERVER_NAME`                             | `drupal`                 |                               |
| `NGINX_SERVER_ROOT`                             | `/var/www/html`          |                               |
| `NGINX_STATIC_CONTENT_ACCESS_LOG`               | `off`                    |                               |
| `NGINX_STATIC_CONTENT_EXPIRES`                  | `30d`                    |                               |
| `NGINX_STATIC_CONTENT_OPEN_FILE_CACHE`          | `max=3000 inactive=120s` |                               |
| `NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_MIN_USES` | `2`                      |                               |
| `NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_VALID`    | `45s`                    |                               |
| `NGINX_XMLRPC_SERVER_NAME`                      |                          |                               |

## Orchestration Actions

See [wodby/nginx](https://github.com/wodby/nginx) for all actions.

## Complete Drupal Stack

See [Docker4Drupal](https://github.com/wodby/docker4drupal).
