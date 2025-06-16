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

run:
	docker-compose up -d
