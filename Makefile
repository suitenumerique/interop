# ==============================================================================
# VARIABLES

BOLD  := \033[1m
RESET := \033[0m
GREEN := \033[1;32m
SHELL := /bin/env bash

# -- Docker
# Get the current user ID to use for docker run and docker exec commands
ifeq ($(OS),Windows_NT)
DOCKER_USER         := 0:0     # run containers as root on Windows
else
DOCKER_UID          := $(shell id -u)
DOCKER_GID          := $(shell id -g)
DOCKER_USER         := $(DOCKER_UID):$(DOCKER_GID)
endif
COMPOSE             = DOCKER_USER=$(DOCKER_USER) docker compose

# ==============================================================================
# RULES
default: help

data/minio:
	mkdir -p data/minio

bootstrap: ## bootstrap the repository (for testing)
bootstrap: \
  data/minio
.PHONY: bootstrap

run: ## run LaSuite core services
	$(COMPOSE) up
.PHONY: run

stop: ## stop LaSuite core services
	$(COMPOSE) stop
.PHONY: stop

down: ## clean LaSuite core services
	$(COMPOSE) down
.PHONY: stop

update-realm:
	$(COMPOSE) stop keycloak
	$(COMPOSE) run keycloak import --file /opt/keycloak/data/import/realm.json
	$(COMPOSE) up -d keycloak
.PHONY: update-realm

# -- Misc
clean: ## restore repository state as it was freshly cloned
	git clean -idx
.PHONY: clean

help:
	@echo -e "$(BOLD)LaSuite Interop Makefile$(RESET)\n"
	@echo -e "Please use 'make $(BOLD)target$(RESET)' where $(BOLD)target$(RESET) is one of:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-30s$(RESET) %s\n", $$1, $$2}'
.PHONY: help
