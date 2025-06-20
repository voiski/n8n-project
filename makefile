.DEFAULT_GOAL := help
.PHONY: help

## Options
################################################################################

# gemma3 vs mistral: https://www.ankursnewsletter.com/p/comparative-analysis-gemma-7b-vs
model ?= gemma3 ## Model to use for ollama, default: gemma3 (light); others: mistral, deepseek-r1 (good), llama4 (huge)
# debug ?= ## Enable debug log lvl.

cpu ?= 4 ## Number of CPUs to allocate for colima
memory ?= 12 ## Memory to allocate for colima
disk ?= 100 ## Disk space to allocate for colima

gpu_enabled ?= false ## Enable ollama gpu support on linux and windows
native_mac ?= false ## Enable ollama gpu support on macos

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
ifeq ($(native_mac), true)
	brew install ollama
endif

bootstrap: init s load-model ## install deps and start it with the default model

s: start
start: ## start local compose with essential services
ifeq ($(native_mac), true)
	docker-compose -f docker-compose.yml -f docker-compose.gpu-macos.yml up -d
	@echo "Ollama server will run with metal libs in foreground, press Ctrl+C to stop"
	OLLAMA_HOST=0.0.0.0 OLLAMA_ORIGINS=* ollama serve
	docker-compose -f docker-compose.yml -f docker-compose.gpu-macos.yml down
else
ifeq ($(gpu_enabled), true)
	@echo "Start docker compose in foreground, press Ctrl+C to stop"
	docker-compose -f docker-compose.yml -f docker-compose.gpu.yml up
else
	docker-compose up
endif
endif

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
