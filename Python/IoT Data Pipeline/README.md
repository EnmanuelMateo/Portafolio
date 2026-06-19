# IoT Data Pipeline — Producer & Consumer

> Python streaming scripts that ingest IoT telemetry from **MQTT**, validate and structure it, stream through **Kafka**, and persist to **PostgreSQL** with per-device-type routing.

![Language](https://img.shields.io/badge/language-Python-blue)
![Streaming](https://img.shields.io/badge/streaming-Kafka%20%7C%20MQTT-success)
![Storage](https://img.shields.io/badge/storage-PostgreSQL-lightgrey)

---

## Overview

This project is the **application layer** of the broader [IoT Sensors data engineering pipeline](../../Data%20Engineer/Iot%20Sensors). Two Python scripts work in tandem:

- **`Producer_MQTT_Kafka_R.py`** — subscribes to MQTT topics, cleans and timestamps incoming JSON, and produces standardized events to Kafka.
- **`Consumer_MQTT_Postgresql_R.py`** — consumes the Kafka topic, classifies each event by device type, and writes to the correct PostgreSQL table with transactional safety.

The combination delivers **scalable, real-time ingestion** with the schema integrity needed for BI and ML downstream.

## Business Problem

A multi-tenant IoT deployment streams telemetry from people counters, environmental sensors, sound-level monitors, and ambience devices — each with its own payload shape. The legacy pattern (raw JSON in PostgreSQL) made analytics slow and brittle. The objective:

- Reliable, high-throughput ingestion
- Per-device-type structured storage for fast BI queries
- Multi-destination routing (Postgres now, Iceberg/BI later) without producer changes

## Technologies

`Python` · `Paho-MQTT` · `Confluent Kafka` · `psycopg2` · `PostgreSQL` · `Docker` · `Linux`

## Architecture

```
   MQTT Broker ──► Producer ──► Kafka topic ──► Consumer ──► PostgreSQL
                  (Paho-MQTT)   (sensor_data)   (psycopg2)   (per-device tables)
```

### Producer responsibilities
- Subscribe to MQTT topics
- Decode JSON, extract `device_info` and `sensor_readings`
- Add ingestion timestamps and defaults for missing fields
- Forward to Kafka with confluent-kafka

### Consumer responsibilities
- Read messages from the `sensor_data` topic
- **Categorize** each device into one of: `People_Counter`, `AI_People_Counter`, `Environmental_Monitoring`, `Multi_Sensor_Monitoring`, `Sound_Level_Monitoring`, `Ambience_Monitoring`, or `Unknown_Devices`
- Insert into the matching PostgreSQL table with rollback on failure

## Methodology

1. **Schema discovery** of MQTT payloads from each sensor vendor.
2. **Canonical event envelope** designed for Kafka (`timestamp`, `device_*`, `sensor_readings`).
3. **Producer** built with error recovery and structured logging.
4. **Consumer** decoupled from the producer through Kafka, enabling horizontal scaling and adding new sinks without producer changes.
5. **Per-type tables** in PostgreSQL replace single-JSON-column storage.

## Key Results

| Metric | Outcome |
| --- | --- |
| Malformed / lost records | **−30%** through validation |
| Query performance | **+40%** vs. JSON-in-Postgres baseline |
| Scalability | Multi-destination routing enabled (Iceberg, BI) |
| Reliability | Automatic rollback preserves DB integrity on consumer failure |

## Repository Structure

```
IoT Data Pipeline/
├── Producer_MQTT_Kafka_R.py     # MQTT → Kafka
├── Consumer_MQTT_Postgresql_R.py # Kafka → PostgreSQL
└── README.md
```

## How to Run

```bash
# 1. Install dependencies
pip install paho-mqtt confluent-kafka psycopg2-binary

# 2. Update connection settings inside each script:
#    - MQTT host / port / topic
#    - Kafka bootstrap.servers
#    - PostgreSQL DB_CONFIG

# 3. Start the producer
python Producer_MQTT_Kafka_R.py

# 4. In a separate process, start the consumer
python Consumer_MQTT_Postgresql_R.py
```

Use the Docker Compose stack from the parent [IoT Sensors](../../Data%20Engineer/Iot%20Sensors) project to spin up Kafka + Postgres locally.

## Future Improvements

- Externalize all credentials to **environment variables** or a `.env` file (never commit secrets).
- Replace ad-hoc message validation with **Pydantic** models or a Confluent **Schema Registry**.
- Add **Prometheus metrics** for ingestion rate, consumer lag, and error counts.
- Containerize each script with its own `Dockerfile` for orchestration via Kubernetes.
- Add **unit + integration tests** with a mocked broker.

---

**Author:** Enmanuel Mateo
