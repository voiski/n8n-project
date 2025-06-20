# n8n-project
N8n sample project created to the I2A2 Autonomous Agents course

## Installation

Requires:
* docker
* docker-compose

Use `make init` to install docker over colima.
* Set `gpu_enabled=true` to the `.env` to have gpu support - only works for linux and windows.
* For macos, you set `native_mac=true` to the `.env` to have gpu support.

> You can also try `make bootstrap` to install dependencies, start the containers, and load the default model.
> Use same variables for gpu support.

### Bootstrap

Start the project with `make start` or `docker-compose up -d`.
Access the http://localhost:5678 and login with your credentials.
The first time will require to sign for a free license.
* You can select "I'll not use n8n for work" to simplify the options.
* Then select to receive the license in the next page.
* Go in the `settings > Usage and plan` and put the active key you received in your email.

Next, you will need to config some connection at [n8n credentials]:
* Add connection for ollama:
    * Base URL: http://ollama:11434
* Add connection for postgres:
    * Host: pgvector
    * Username: n8n
    * Password: n8n-pgvector
    * Database: db

You can also play around ollama webui at http://localhost:3000.
* If not done yet, load a model using `make load-model`
* We default to `gemma3`, but you can load different models using `make load-model model=<model_name>`

### The makefile

Run `make help` to see all available targets and options.

```bash
Targets:
	help                           This help.
	init                           Install dependencies and init container provider
	bootstrap                      install deps and start it with the default model
	start                          start local compose with essential services
	status                         show status of local compose
	stop                           stop local compose
	logs                           show logs of local compose
	load-model                     load model into local compose using model=<model> options, check https://ollama.com/library
	open-ollama                    open ollama in browser

Options:
	model                          Model to use for ollama, default: gemma3 (light); others: mistral, deepseek-r1 (big), llama4 (huge)
	cpu                            Number of CPUs to allocate for colima
	memory                         Memory to allocate for colima
	disk                           Disk space to allocate for colima
	gpu_enabled                    Enable ollama gpu support on linux and windows
	native_mac                     Enable ollama gpu support on macos
```

## Development

Start the project with `make start` or `docker-compose up -d`.
Access the http://localhost:5678 and login with your credentials.

Ensure to store the workflows in the `workflows` directory so we can keep it versioned.

At now, all the workflows will need to be imported manually. Please, name the workflows to match the file names.
* `workflows/sample.json` Simple sample from https://n8n.io/workflows/2729-private-and-local-ollama-self-hosted-ai-assistant/
* `workflows/project-1.json` Our current solution for the project [project-1 requirements].

### Testing

TBD - we need to define what is a test strategy here. I.E. We can define samples for workflows.

### Deployment

TBD - we still need to define a provider, but we can refer to the official [server-setups] documentation.

## Contributions
Feel free to ask for access to the project.
You can also fork and open a pull request.

[server-setups]: https://docs.n8n.io/hosting/installation/server-setups/
[n8n credentials]: http://localhost:5678/home/credentials
[project-1 requirements]: https://sites.google.com/i2a2.academy/agentes-autonomos-com-ia-gen/atividade-obrigat%C3%B3ria-2025-06-18
