up: stop
	git pull && sudo docker-compose up

run:
	sudo docker-compose up -d

stop:
	sudo docker-compose down

restart: stop run
