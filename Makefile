run:
	docker-compose build
	docker-compose up --force-recreate -d
	docker image prune -f
	docker-compose logs -f --tail=100

stop:
	docker-compose down

restart: stop run
