-include env_make

NGINX ?= 1.13
VERSION ?= 7-$(NGINX)

REPO = wodby/drupal-nginx
NAME = drupal7-nginx-$(NGINX)

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(VERSION) --build-arg NGINX_VER=$(NGINX) ./

test:
	IMAGE=$(REPO):$(VERSION) ./test.sh

push:
	docker push $(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
