# n8n-project
N8n sample project created to the I2A2 Autonomous Agents course

## Installation

Requires:
* docker
* docker-compose

Use `make init` to install docker over colima.

### Bootstrap

Start the project with `make start` or `docker-compose up -d`.
Access the http://localhost:5678 and login with your credentials.
The first time will require to sign for a free license.
* You can select "I'll not use n8n for work" to simplify the options.
* Then select to receive the license in the next page.
* Go in the `settings > Usage and plan` and put the active key you received in your email.

## Development

Start the project with `make start` or `docker-compose up -d`.
Access the http://localhost:5678 and login with your credentials.

Ensure to store the workflows in the `workflows` directory so we can keep it versioned.

### Testing

TBD - we need to define what is a test strategy here. I.E. We can define samples for workflows.

### Deployment

TBD - we still need to define a provider, but we can refer to the official [server-setups] documentation.

## Contributions
Feel free to ask for access to the project.
You can also fork and open a pull request.

[server-setups]: https://docs.n8n.io/hosting/installation/server-setups/
