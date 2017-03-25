# Docker Dev

This is the LEMP (Linux, Enginx, MySQL, PHP) docker setup I use for development.

### Installation

Clone the repository

```sh
$ git clone https://github.com/ksaurabhsinha/docker_dev.git
```

Customize the configuration by renaming the `.env.example` to `.env` and edit acording to your requirements.

```
PROJECT_ROOT=./www/html
DB_ROOT_PASSWORD=secret
DB_NAME=project
DB_USERNAME=project
DB_PASSWORD=project
```

Initialize the setup

```sh
$ docker-compose up -d
```

Enjoy
