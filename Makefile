up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
init:
	mkdir -p ./docker/php/bash/psysh
	touch ./docker/php/bash/.bash_history
	cp .env.template .env
	docker-compose up --build -d && sleep 10
	docker-compose exec app composer install
	docker-compose exec app cp .env.example .env
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	docker-compose exec app chmod -R 777 storage/
	docker-compose exec app php artisan migrate:fresh
remake:
	@make stop
	@make destroy
	@make init
restart:
	docker-compose restart
stop:
	docker-compose stop
down:
	docker-compose down
destroy:
	docker-compose rm -fv
destroy-volumes:
	docker-compose down --volumes
ps:
	docker-compose ps
