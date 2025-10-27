PY := python3.12
PYTHON_VERSION = 3.12
PHP_VERSION = 8.4
VENV := venv
REPONAME=$(basename $(pwd))
DOCKER=docker
DOCKER_COMPOSE = docker-compose
PHP_SERVICE := php_dev

# Nombre del contenedor de pruebas
CONTAINER_NAME=php_dev

TEST_PATH = tests/
REPORTS_DIR = reports

.PHONY: all build up down restart clean shell composer-install composer-update logs
.PHONY: build_docs up_docs down_docs restart_docs clean_docs


# Default target
all: build up

# Construir la imagen con docker-compose
build:
	$(DOCKER_COMPOSE) build

# Levantar el contenedor en segundo plano
up:
	$(DOCKER_COMPOSE) up -d

# Conectar al contenedor con una terminal interactiva
shell:
	docker exec -it $(CONTAINER_NAME) bash

# Parar el contenedor
down:
	$(DOCKER_COMPOSE) down

# Eliminar el contenedor y la imagen
clean:
	$(DOCKER_COMPOSE) down -v --rmi local --remove-orphans
#	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

# Run Composer install in the PHP container
composer-install:
	$(DOCKER_COMPOSE) exec $(PHP_SERVICE) composer install

# Run Composer update in the PHP container
composer-update:
	$(DOCKER_COMPOSE) exec $(PHP_SERVICE) composer update

# View logs for all services
logs:
	$(DOCKER_COMPOSE) logs -f


############# Docs ############
DOCKERFILE_DIR_DOCS := ./src/containers/docs
IMAGE_NAME_DOCS := php-docs
CONTAINER_NAME_DOCS := php-docs
PORT_DOCS := 8080

# Construye la imagen Docker usando el Dockerfile en /src/containers/docs/
build_docs:
	$(DOCKER) build -t $(IMAGE_NAME_DOCS) -f $(DOCKERFILE_DIR_DOCS)/Dockerfile .

# Levanta el contenedor y expone el puerto 8080 (con live-reload y montado de volumen)
run_docs:
#	 $(DOCKER) run --rm -it -p $(PORT_DOCS):$(PORT_DOCS) -v $(PWD):/app $(IMAGE_NAME_DOCS)
	$(DOCKER) run --rm -it \
		--name $(CONTAINER_NAME_DOCS) \
		-p $(PORT_DOCS):$(PORT_DOCS) \
		-v $(PWD)/mkdocs.yml:/app/mkdocs.yml \
		-v $(PWD)/docs:/app/docs \
		$(IMAGE_NAME_DOCS)

# Detiene y elimina el contenedor (si está en segundo plano)
clean_docs:
	$(DOCKER) stop $(CONTAINER_NAME_DOCS) || true
	$(DOCKER) rm $(IMAGE_NAME_DOCS) || true

# Atajo para build + run
up_docs: build_docs run_docs

################# LOCAL  ENVIRONMENT ############################

.PHONY: local_env
local_env: $(VENV)
	@echo "Installed project in virtual environment..."
	@echo "Linux: Use \"source venv/bin/activate\""
#	@echo "Linux: Run \"poetry install\""
	@echo ${REPONAME}


.PHONY: clean_local_env
clean_local_env: ${VENV}
	rm -rf dist
	rm -rf ${VENV}
	rm -rf poetry.lock
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete


.PHONY: clean_local_env_cache
clean_local_env_cache: ${VENV}
	find . -type f -name *.pyc -delete
	ind . -type d -name __pycache__ -delete
