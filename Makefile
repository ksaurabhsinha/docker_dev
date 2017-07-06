include .env

.PHONY: all build

LIGHT_GREEN := $(shell echo "\033[1;32m")
RED := $(shell echo "\033[0;31m")
NC := $(shell echo "\033[0m") # No Color

include makefiles/*.mk

setup:
	$(call message, Building the Docker Containers)
	@docker-compose up -d --build --force-recreate

initialize:
	$(call message, Creating project directory and permissions)
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_DIRECTORY};
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${PROJECT_DIRECTORY};

	@echo "Creating the log directory and permissions";
	@mkdir -p ${PROJECT_ROOT}/${LOG_DIRECTORY};
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${LOG_DIRECTORY};
	@sudo chmod -R 777 ${PROJECT_ROOT}/${LOG_DIRECTORY};

	@mkdir -p ${PROJECT_ROOT}/${DATABASE_DIRECTORY};
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${DATABASE_DIRECTORY};
	@sudo chmod -R 777 ${PROJECT_ROOT}/${DATABASE_DIRECTORY};

create_data_dir:
	@mkdir -p ${PROJECT_ROOT}/${DATABASE_DIRECTORY};
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${DATABASE_DIRECTORY};
	@sudo chmod -R 777 ${PROJECT_ROOT}/${DATABASE_DIRECTORY};

clone_repo:
	$(call message, Cloning the Repo)
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && git clone ${REPO_URL} .

project_setup:
	$(call message, Setting up the project)
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 storage && cp .env.example .env
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 bootstrap/cache
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && git config core.fileMode false

laravelfix:
	@docker exec dockerdev_php_1 php artisan key:generate

infra_pull: intro_text
	@git pull

project_start: intro_text
	$(call message, Starting Containers)
	@docker-compose up -d

project_down: intro_text
	$(call message, Stopping Containers)
	@docker-compose down

project_restart: intro_text project_down project_start

project_recreate: intro_text project_down create_data_dir
	@docker-compose up -d --build --force-recreate

success:
	@echo "${RED} ****************************************************************"
	@echo "${RED} *                                                              *"
	@echo "${RED} *             Setup is complete. We are good to go.            *"
	@echo "${RED} *                                                              *"
	@echo "${RED} ****************************************************************"

install: initialize setup clone_repo project_setup project_restart laravelfix success
