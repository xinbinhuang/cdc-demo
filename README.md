# CDC Kafka

This is a CDC demo using Kafka connect and Debezium to sync CDC stream from _SQL Server_ to _db2_.

## Components

- Zoo keeper
- Kafka broker
- Confluent control center
- Kafka connect
- `MSSQL Server`
  - `SA_PASSWORD` is the database system administrator (userid = 'sa') password used to connect to SQL Server once the container is running. Important note: This password needs to include at least 8 characters of at least three of these four categories: uppercase letters, lowercase letters, numbers and non-alphanumeric symbols.
- `db2`

## Prerequisite

- Docker
- Docker-compose
- `curl`
- `jq`

## Steps

1. Launch the required services

  ```bash
  docker-compose up
  ```

2. Seed the data into mssql database and enable CDC

  ```bash
  cat mssql_seed.sql | docker-compose exec -T mssql bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P Pass@word'
  ```

3. Submit config for source and sink connector

   - Source: sync data from mssql server to Kafka topic
     - `curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @mssql-source.json`
   - Sink  : Replicate data from topic to db2
     - `curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @db2-sink.json`

You can check the topics and other information throught the UI at http://localhost:9021
