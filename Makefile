include .env

.PHONY: all build

LIGHT_GREEN := $(shell echo -e "\033[1;32m")
NC := $(shell echo -e "\033[0m") # No Color

setup:
	@echo "${LIGHT_GREEN} ============= Building the Docker Containers =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	docker-compose up -d --build

initialize:
	@echo "${LIGHT_GREEN} ============= Creating project directory and permissions =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	mkdir -p ${PROJECT_ROOT}/${PROJECT_DIRECTORY};
	sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${PROJECT_DIRECTORY};

	echo "Creating the log directory and permissions";
	mkdir -p ${PROJECT_ROOT}/${LOG_DIRECTORY};
	sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${LOG_DIRECTORY};
	sudo chmod -R 777 ${PROJECT_ROOT}/${LOG_DIRECTORY};

clone_repo:
	@echo "${LIGHT_GREEN} ============= Cloning the Repo =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && git clone ${REPO_URL} .

project_setup:
	@echo "${LIGHT_GREEN} ============= Setting up the project =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 storage && cp .env.example .env
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 bootstrap/cache
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && git config core.fileMode false

laravelfix:
	docker exec dockerdev_php_1 php artisan key:generate

infra_pull:
	git pull

project_start:
	@echo "${LIGHT_GREEN} ============= Starting Containers =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	docker-compose up -d

project_down:
	@echo "${LIGHT_GREEN} ============= Stopping Containers =================${NC}"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	docker-compose down

project_restart: project_down project_start

install: initialize setup clone_repo project_setup project_restart laravelfix
