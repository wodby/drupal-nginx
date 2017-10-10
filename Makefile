-include env_make

DRUPAL_VER ?= 8
NGINX_VER ?= 1.13
TAG ?= $(DRUPAL_VER)-$(NGINX_VER)

FROM_TAG = $(NGINX_VER)
REPO = wodby/drupal-nginx
NAME = drupal-$(DRUPAL_VER)-nginx-$(NGINX_VER)

ifneq ($(FROM_STABILITY_TAG),)
    FROM_TAG := $(FROM_TAG)-$(FROM_STABILITY_TAG)
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg FROM_TAG=$(FROM_TAG) --build-arg DRUPAL_VER=$(DRUPAL_VER) ./

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
