include .env

.PHONY: all build

setup:
	docker-compose up -d --build

initialize:
	echo "Creating project directory and permissions"
	mkdir -p ${PROJECT_ROOT}/${PROJECT_DIRECTORY};
	sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${PROJECT_DIRECTORY};

	echo "Creating the log directory and permissions";
	mkdir -p ${PROJECT_ROOT}/${LOG_DIRECTORY};
	sudo chown -R ${USER:=$(/usr/bin/id -run)} ${PROJECT_ROOT}/${LOG_DIRECTORY};
	sudo chmod -R 777 ${PROJECT_ROOT}/${LOG_DIRECTORY};

clone_repo:
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && git clone ${REPO_URL} .

project_setup:
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 storage && cp .env.example .env && composer dump-autoload --optimize
	cd ${PROJECT_ROOT}/${PROJECT_DIRECTORY} && chmod -R 777 bootstrap/cache

reinitialize:
	docker-compose down
	docker-compose up -d

laravelfix:
	docker exec dockerdev_php_1 php artisan key:generate

infra_pull:
	git pull

project_start:
	docker-compose up -d

project_down:
	docker-compose down

project_restart: project_down project_start

install: initialize setup clone_repo project_setup reinitialize laravelfix
