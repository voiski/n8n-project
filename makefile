.DEFAULT_GOAL := help
.PHONY: help

## Options
################################################################################

model ?= gemma3 ## Model to use for ollama, default: gemma3 (light); others: deepseek-r1 (good), llama4 (huge)
# debug ?= ## Enable debug log lvl.

cpu ?= 4 ## Number of CPUs to allocate for colima
memory ?= 12 ## Memory to allocate for colima
disk ?= 100 ## Disk space to allocate for colima

## Targets
################################################################################

h: help
help: ## This help.
	@printf "\033[36m%-30s\033[0m %s\n" "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

	@printf "\n\033[36m%-30s\033[0m %s\n" "Options:"
	@awk 'BEGIN {FS = " \\?=.*?## "} /^[a-zA-Z_-]+ *?\?=.*?## / {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Install dependencies and init container provider
	brew install colima docker docker-compose
	# Ensure to have enough resources for colima to run local llms
	colima start --cpu $(cpu) --memory $(memory) --disk $(disk)

bootstrap: init s load-model ## install deps and start it with the default model

s: start
start: ## start local compose with essential services
	docker-compose up -d

ps: status
st: status
status: ## show status of local compose
	docker-compose ps

down: stop
stop: ## stop local compose
	docker-compose down

l: logs
logs: ## show logs of local compose
	docker-compose logs -f

load-model: ## load model into local compose using model=<model> options, check https://ollama.com/library
	docker-compose exec -it ollama ollama pull $(model)

n8n: open-n8n
open-n8n: ## open n8n in browser
	open http://localhost:5678

ollama: open-ollama
open-ollama: ## open ollama in browser
	open http://localhost:3000
