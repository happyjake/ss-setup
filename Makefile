up: stop
	git pull && sudo docker-compose up

run:
	sudo docker-compose up -d

stop:
	sudo docker-compose down

restart: stop run

conf:
	sed -e s/SSPORT/$(port)/g -e s/SSPASSWORD/$(pwd)/g docker-compose.yml.tmpl > docker-compose.yml
