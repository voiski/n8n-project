.DEFAULT_GOAL := help
.PHONY: help

## Options
################################################################################

# debug ?= ## Enable debug log lvl.

## Targets
################################################################################

help: ## This help.
	@printf "\033[36m%-30s\033[0m %s\n" "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

	@printf "\n\033[36m%-30s\033[0m %s\n" "Options:"
	@awk 'BEGIN {FS = " \\?=.*?## "} /^[a-zA-Z_-]+ *?\?=.*?## / {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init:
	brew install colima docker docker-compose
	colima start

start:
	docker-compose up -d

status:
	docker-compose ps

stop:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f
