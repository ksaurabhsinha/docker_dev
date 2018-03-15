include .env

export PROJECT_NAME
export MEMORY_SIZE
export DISK_SIZE

.PHONY: all build setup install

# SHELL := /bin/bash

#Define Colors to be used
LIGHT_GREEN := $(shell echo "\033[1;32m")
RED := $(shell echo "\033[0;31m")
CYN := $(shell echo "\033[0;36m")
NC := $(shell echo "\033[0m") # No Color

include build/makefiles/*.mk

create_machine:
	@source build/shell/machine && machine create

destroy_machine:
	@docker-machine stop ${PROJECT_NAME}
	@docker-machine rm ${PROJECT_NAME}
	@sudo rm -r ~/${PROJECT_NAME}

prepare_directories:
	$(call message, Creating project directory and permissions)
	@mkdir -p ~/${PROJECT_NAME}/src;
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ~/${PROJECT_NAME}/src;

	$(call message, Creating the log directory and permissions)
	@mkdir -p ~/${PROJECT_NAME}/logs;
	@sudo chown -R ${USER:=$(/usr/bin/id -run)} ~/${PROJECT_NAME}/logs;
	@sudo chmod -R 777 ~/${PROJECT_NAME}/logs;

setup:
	$(call message, Building the Docker Containers)
	@eval $$(docker-machine env ${PROJECT_NAME}) && docker-compose up -d --build --force-recreate

clone_repo:
	$(call message, Cloning the Repo)
	cd ~/${PROJECT_NAME}/src && git clone ${REPO_URL} .

project_setup:
	$(call message, Setting up the project)
	cd ~/${PROJECT_NAME}/src && chmod -R 777 storage && cp .env.example .env
	cd ~/${PROJECT_NAME}/src && chmod -R 777 bootstrap/cache
	cd ~/${PROJECT_NAME}/src && git config core.fileMode false
	cd ~/${PROJECT_NAME}/src && composer install

laravelfix:
	@eval $$(docker-machine env ${PROJECT_NAME}) && docker exec ${PROJECT_NAME}_php php artisan key:generate

infra_pull: intro_text
	@git pull

project_start: intro_text
	$(call message, Starting Containers)
	@eval $$(docker-machine env ${PROJECT_NAME}) && docker-compose up -d

project_down: intro_text
	$(call message, Stopping Containers)
	@eval $$(docker-machine env ${PROJECT_NAME}) && docker-compose down

project_restart: intro_text project_down project_start

project_recreate: intro_text project_down
	@eval $$(docker-machine env ${PROJECT_NAME}) && docker-compose up -d --build --force-recreate

success:
	@echo "${CYN} ****************************************************************"
	@echo "${CYN} *                                                              *"
	@echo "${CYN} *             Setup is complete. We are good to go.            *"
	@echo "${CYN} *                                                              *"
	@echo "${CYN} ****************************************************************"

project_config:
	@echo "\n \n"
	@echo "${LIGHT_GREEN} --------------------- Project configuration details ---------------------"
	@echo "${CYN} Machine IP Address:  ----- ${LIGHT_GREEN} $$(docker-machine ip ${PROJECT_NAME})"
	@echo "${CYN} Machine Name:        ----- ${LIGHT_GREEN} ${PROJECT_NAME}"
	@echo "${CYN} Web Url:             ----- ${LIGHT_GREEN} http://$$(docker-machine ip ${PROJECT_NAME})"
	@echo "${CYN} MySQL Host:          ----- ${LIGHT_GREEN} mysql (when connecting from inside the application)"
	@echo "${CYN}                      ----- ${LIGHT_GREEN} $$(docker-machine ip ${PROJECT_NAME}) (when connecting from outside the application)"
	@echo "${CYN} MySQL User:          ----- ${LIGHT_GREEN} ${DB_USERNAME}"
	@echo "${CYN} MySQL Password:      ----- ${LIGHT_GREEN} ${DB_PASSWORD}"
	@echo "${CYN} MySQL Root User:     ----- ${LIGHT_GREEN} root"
	@echo "${CYN} MySQL Root Password: ----- ${LIGHT_GREEN} ${DB_ROOT_PASSWORD}"
	@echo "${CYN} PhpMyAdmin:          ----- ${LIGHT_GREEN} http://$$(docker-machine ip ${PROJECT_NAME}):8080"
	@echo "\n"

install: intro_text create_machine prepare_directories setup clone_repo project_setup project_restart laravelfix success project_config
