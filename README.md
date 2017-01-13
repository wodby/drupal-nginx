# drupal-nginx

Add varibles `ENV_DEV` for disable/enable gzip cache.

For example:

    nginx:
	    image: wodby/drupal-nginx
	    environment:
	      NGINX_SERVER_NAME: localhost
          NGINX_UPSTREAM_NAME: php
          DRUPAL_VERSION: 7 # Allowed: 7, 8.
	      DEV_ENV: 1 # Disable gzip.
	    volumes_from:
	      - php
	    ports:
	      - "8000:80"

[![Build Status](https://travis-ci.org/Ruslan03492/drupal-nginx.svg?branch=master)](https://travis-ci.org/Ruslan03492/drupal-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/rutel/drupal-nginx.svg)](https://hub.docker.com/r/rutel/drupal-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/rutel/drupal-nginx.svg)](https://hub.docker.com/r/rutel/drupal-nginx)

# Supported tags and respective `Dockerfile` links

-       [`1.10`, `latest` (*1.10/Dockerfile*)](https://github.com/Ruslan03492/drupal-nginx/blob/master/1.10/Dockerfile)
