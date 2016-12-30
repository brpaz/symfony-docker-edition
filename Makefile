CURRENT_DIRECTORY := $(shell pwd)

help:
	@echo "Symfony docker edition"
	@echo "-----------------------"
	@echo ""
	@echo "Starts the application containers"
	@echo "    make start"
	@echo ""
	@echo "Stops the application containers"
	@echo "    make stop"
	@echo ""
	@echo "Show the status of application containers"
	@echo "    make status"
	@echo ""
	@echo "See contents of Makefile for more targets."

start:
	@docker-compose up -d

stop:
	@docker-compose stop

status:
	@docker-compose ps

restart: stop start

build:
	@docker-compose build app

rebuild:
	@docker-compose down
	@docker-compose build
	@docker-compose up

clearcache:
	@docker-compose run --rm app bin/console cache:clear

console:
	@docker-compose run --rm app bin/console

logs:
	@docker-compose logs -f

.PHONY: start stop status restart build test console logs
