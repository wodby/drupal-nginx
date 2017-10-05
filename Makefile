-include env_make

DRUPAL_VER ?= 8
NGINX_VER ?= 1.13
TAG ?= $(DRUPAL_VER)-$(NGINX_VER)

REPO = wodby/drupal-nginx
NAME = drupal-$(DRUPAL_VER)-nginx-$(NGINX_VER)

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg NGINX_VER=$(NGINX_VER) --build-arg DRUPAL_VER=$(DRUPAL_VER) ./

test:
	cd test/$(DRUPAL_VER) && IMAGE=$(REPO):$(TAG) ./test.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
