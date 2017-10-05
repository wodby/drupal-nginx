# Nginx for Drupal Docker Container Image

[![Build Status](https://travis-ci.org/wodby/drupal-nginx.svg?branch=master)](https://travis-ci.org/wodby/drupal-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/drupal-nginx.svg)](https://hub.docker.com/r/wodby/drupal-nginx)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

* All images are based on Alpine Linux
* Base image: [wodby/php-nginx](https://github.com/wodby/php-nginx)
* [Travis CI builds](https://travis-ci.org/wodby/drupal-nginx) 
* [Docker Hub](https://hub.docker.com/r/wodby/drupal-nginx)

| Image tag (Dockerfile)                                                 | Drupal | Nginx | 
| ---------------------------------------------------------------------- | ------ | ----- | 
| [8-1.13](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 8      | 1.13  | 
| [7-1.13](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 7      | 1.13  | 
| [6-1.13](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 6      | 1.13  | 
| [8-1.12](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 8      | 1.12  | 
| [7-1.12](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 7      | 1.12  | 
| [6-1.12](https://github.com/wodby/drupal-nginx/tree/master/Dockerfile) | 6      | 1.12  | 

## Environment Variables

See at [wodby/php-nginx](https://github.com/wodby/php-nginx)

| Variable                                      | Default Value          | Description |
| --------------------------------------------- | ---------------------- | ----------- |
| NGINX_ALLOW_XML_ENDPOINTS                     |                        |             |
| NGINX_DRUPAL_HIDE_HEADERS                     |                        |             |
| NGINX_DRUPAL_TRACK_UPLOADS                    | uploads 60s            |             |
| NGINX_SERVER_EXTRA_CONF_FILEPATH              |                        |             |
| NGINX_SERVER_NAME                             | drupal                 |             |
| NGINX_SERVER_ROOT                             | /var/www/html          |             |
| NGINX_STATIC_CONTENT_ACCESS_LOG               | off                    |             |
| NGINX_STATIC_CONTENT_EXPIRES                  | 30d                    |             |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE          | max=3000 inactive=120s |             |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_MIN_USES | 2                      |             |
| NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_VALID    | 45s                    |             |
| NGINX_XMLRPC_SERVER_NAME                      |                        |             |

## Complete Drupal Stack

See [Docker4Drupal](https://github.com/wodby/docker4drupal).
