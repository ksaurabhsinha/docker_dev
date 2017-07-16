# Docker Dev

This is the LEMP (Linux, Nginx, MySQL, PHP) docker setup I use for development.
This is majorly focused on Laravel but can be modified very easily.

### Clone the repository

```sh
$ git clone https://github.com/ksaurabhsinha/docker_dev.git
```

Customize the configuration by renaming the `.env.example` to `.env` and edit according to your requirements.

### Handling multiple projects simultaneously

```
$ mkdir project_name
$ cd project_name
$ git clone https://github.com/ksaurabhsinha/docker_dev.git .
$ make install
```

```
$ mkdir project_name_2
$ cd project_name_2
$ git clone https://github.com/ksaurabhsinha/docker_dev.git .
$ make install
```

### Initialize the setup

```sh
make install
```

Enjoy
