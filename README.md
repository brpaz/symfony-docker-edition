# Symfony Docker edition

> Sample [Symfony](https://github.com/symfony/symfony) project optimized for [Docker](https://www.docker.com/) and [Docker Compose](https://github.com/docker/compose).

Symfony runs on a basic LAMP / LEMP stack which is not hard to configure locally, but what happens if you are working in multiple
projects at the same time? Maybe one of them is using bleeding edge PHP7 but another still an older version of php?
Docker helps managing this and other problems by providing a way to have a isolated and reproducible environment without the burden of a fully featured
VM.
Still, for having a good working Docker environment, some time in order to configure everything properly.
The goal of this project is to provide a good example how to run a Symfony based application on Docker for development purposes, following best practices and
use the best tools available.

This project is based on latest Symfony 3.2 version.
You should have at least a basic understanding how docker and docker-compose works.

## Requirements

You need to have [Docker](https://www.docker.com/) and [Docker Compose](https://github.com/docker/compose) installed and configured on your machine.

You can install both, by following [this](https://docs.docker.com/engine/installation/linux/ubuntulinux/) and [this](https://docs.docker.com/compose/insta)
guides.
Optionally, if you want to have your containers easily accessible by dns, you can use [dnsdock](https://github.com/aacebedo/dnsdock),
which is a very simple service discovery tool that can run itself as a docker container and automatically registers new created containers.
[This gist](https://gist.github.com/rguimaraens/44bab7ec7a343a09d7c78b07a17ecb4c) contains a more detailed guide of how to install dnsdock on latest versions
of Ubuntu.

**Note** This project is being developed and testing on Linux machine.  For running docker on MAC or Windows some extra steps might be needed. Please look at respective documentation.

## Run the project

After you have docker and compose properly setup, just run ```docker-compose up -d``` on the root of the project.

Run ```docker ps``` to confirm your containers are running. You should have 3 containers (app, nginx and mysql).

To get the ip of your container just do:

```docker inspect <containerid> | grep "IPAddress"```

Where *containerid* is the value returned from ``docker ps``` (look for nginx container)

If you try to access that ip, you should see the Symfony standard welcome page.
If you have configured dnsdock, you can also use ```http://symfony.docker``` or ```http://web.symfony.docker``` to access the application,

## Tips and Tricks

#### Open shell in the application container

```
docker-compose run app sh
```

#### Run symfony console command

```
docker-compose run app bin/console cache:clear
```

# TODO

* Configure application logs to log to stdout / stderr.
* Integrating XDEBUG.
* Improve container building processes for dev / production.
* Improve Makefile or find better alternative (fabric, robo etc).
* Build a basic application, with more dependencies like Redis or Memcached to demonstrate better the use of Environment variables and how to integrate the containers.
* Add kubernetes service definitions.


## Contributing

All contributions are welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT @ Bruno Paz
