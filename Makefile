RUN := run --rm
DOCKER_COMPOSE_RUN := docker-compose $(RUN)

init:
	@make build
	@make install
	@make dbcreate
	@make dbmigrate

build:
	docker-compose build

up:
	docker-compose up

upd:
	docker-compose up -d

down:
	docker-compose down

install:
	${DOCKER_COMPOSE_RUN} app bundle install

dbcreate:
	${DOCKER_COMPOSE_RUN} app rails db:create


dbmigrate:
	${DOCKER_COMPOSE_RUN} app rails db:migrate
	${DOCKER_COMPOSE_RUN} app rails db:migrate RAILS_ENV=test

dbreset:
	${DOCKER_COMPOSE_RUN} app rails db:migrate:reset
	${DOCKER_COMPOSE_RUN} app rails db:migrate:reset RAILS_ENV=test