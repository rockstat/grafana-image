
build:
	docker build -t grafana .

tag-dev:
	docker tag grafana rockstat/grafana:dev

tag-latest:
	docker tag grafana rockstat/grafana:latest

push-latest:
	docker push rockstat/grafana:latest

run:
	docker run --rm -p 8087:8080 rockstat/grafana:dev 

