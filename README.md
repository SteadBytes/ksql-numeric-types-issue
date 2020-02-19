# KSQL Numeric Types Conversion Error Investigation

Minimal reproducible example of KSQL `Failed to convert schema to KSQL model: Invalid Decimal schema: precision parameter not found.` error with numeric data types.

Requires `docker-compose`.

## Usage

1. Start services (wait until logs have settled indicating everything is running).

```
$ docker-compose up
```

2. Initialise PostgreSQL database from `num_types.sql`.

```
$ PGPASSWORD=postgres psql -h localhost -U postgres postgres < num_types.sql
``` 

3. Start the PostgreSQL connector.

```
$ curl -X POST -H "Content-Type: application/json" --data @connector.json http://localhost:8083/connectors
```

4. Connect to KSQL CLI.

```
$ docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088
```

5. Check topics have been created from PostgreSQL connector (it may take a few
seconds for them to appear after creating the data in PostgreSQL).

```
ksql> SHOW TOPICS;

 Kafka Topic                 | Partitions | Partition Replicas
---------------------------------------------------------------
 default_ksql_processing_log | 1          | 1
 num_types_decimal_val       | 1          | 1
 num_types_double_val        | 1          | 1
 num_types_integer_val       | 1          | 1
 num_types_numeric_val       | 1          | 1
 num_types_real_val          | 1          | 1
 playground-config           | 1          | 1
 playground-offsets          | 25         | 1
 playground-status           | 5          | 1
---------------------------------------------------------------
```

6. Attempt to create a stream for each data type example, `numeric` and `double`
fail with `Failed to convert schema to KSQL model: Invalid Decimal schema: precision parameter not found.`

```
ksql> CREATE STREAM numeric_val WITH(KAFKA_TOPIC='num_types_numeric_val', VALUE_FORMAT='Avro');
Failed to convert schema to KSQL model: Invalid Decimal schema: precision parameter not found.
ksql> CREATE STREAM decimal_val WITH(KAFKA_TOPIC='num_types_decimal_val', VALUE_FORMAT='Avro');
Failed to convert schema to KSQL model: Invalid Decimal schema: precision parameter not found.
ksql> CREATE STREAM integer_val WITH(KAFKA_TOPIC='num_types_integer_val', VALUE_FORMAT='Avro');

 Message
----------------
 Stream created
----------------
ksql> CREATE STREAM real_val WITH(KAFKA_TOPIC='num_types_real_val', VALUE_FORMAT='Avro');

 Message
----------------
 Stream created
----------------
ksql> CREATE STREAM double_val WITH(KAFKA_TOPIC='num_types_double_val', VALUE_FORMAT='Avro');

 Message
----------------
 Stream created
----------------
```