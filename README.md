# debezium-mariadb-connector-with-aws-schema-registry-converter

This is a project to build a debezium MariaDB Connector that includes a library for using AWS Schema Registry Converter and AWS Secrets Manager.

## architecture

The assumed architecture is as follows.

```mermaid
graph LR

subgraph AWS Account-a
    RDS
end

RDS-->msk_connector[debezium MSK Connector]-->msk_cluster[MSK Cluster]-->msk_connector_sink_iceberg[MSK Connector Sink Iceberg]-->Iceberg

subgraph AWS Account data-platform
    msk_connector[debezium MSK Connector]--register schema-->glue_schemaregistry[Glue Schema Registry]
    msk_connector_sink_iceberg[MSK Connector Sink Iceberg]--read schema-->glue_schemaregistry[Glue Schema Registry]
    msk_cluster[MSK Cluster]
    Iceberg
end
```

## Usage

- build

```console
make
```

- clean

```console
make clean
```
