up: stop
	git pull && sudo docker-compose up

run:
	sudo docker-compose up -d

update-images:
	sudo docker-compose pull
	sudo docker-compose up --force-recreate --build -d
	sudo docker image prune -f
	docker-compose log -f --tail=100

stop:
	sudo docker-compose down

restart: stop run

conf:
	sed -e s/SNPORT/$(snport)/g -e s/SNPSK/$(snpsk)/g -e s/SSPORT/$(port)/g -e s/SSPASSWORD/$(pwd)/g docker-compose.yml.tmpl > docker-compose.yml
