start:
	docker-compose up -d

seed:
	cat mssql_seed.sql | docker-compose exec -T mssql bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P Pass@word'

sink:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @db2-sink.json

source:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @mssql-source.json

clean:
	docker stop $$(docker ps -qa)
	docker rm $$(docker ps -qa)
	docker system prune -f
	docker volume rm $$(docker volume ls -q);
