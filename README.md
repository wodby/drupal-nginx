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

