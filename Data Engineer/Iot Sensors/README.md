# IoT Sensors — End-to-End Data Engineering Pipeline

> Real-time IoT pipeline that replaces a JSON-in-PostgreSQL legacy with a modular **MQTT → Kafka → PostgreSQL → Apache Iceberg** architecture deployed on Linux.

![Status](https://img.shields.io/badge/status-production-green)
![Stack](https://img.shields.io/badge/stack-Kafka%20%7C%20PostgreSQL%20%7C%20Iceberg-blue)
![Platform](https://img.shields.io/badge/platform-Docker%20%7C%20Linux-lightgrey)

---

## Overview

A scalable end-to-end data pipeline that modernizes an existing IoT data architecture. The previous system stored raw MQTT JSON payloads directly in PostgreSQL, which made querying slow, schema evolution painful, and historical analysis impractical.

The new architecture streams sensor telemetry from an MQTT broker into Kafka, fans it out to a structured PostgreSQL operational store for analytics, and lands it in Apache Iceberg for long-term storage and time-travel queries — all running in Docker on a remote Linux server.

## Business Problem

An IoT deployment producing telemetry from people counters, environmental sensors, and ambience monitors had outgrown its original storage model. Specifically:

- **Slow analytics.** Querying raw JSON blobs blocked BI dashboards.
- **No historical record.** Data was overwritten or aged out before it could be analyzed.
- **Tight coupling.** A single destination meant any new consumer (BI, ML, alerting) required upstream changes.
- **No quality gate.** Malformed payloads silently corrupted downstream reports.

The objective was to deliver a streaming platform that could **ingest reliably, store structurally, and route to multiple destinations** with zero downtime during cutover.

## Architecture

```
   IoT Sensors
       │ MQTT
       ▼
 ┌──────────────┐    ┌──────────────┐    ┌──────────────────┐
 │  Producer    │──► │    Kafka     │──► │   Consumer       │
 │ (Paho-MQTT)  │    │ (Confluent)  │    │ (psycopg2)       │
 └──────────────┘    └──────┬───────┘    └────────┬─────────┘
                            │                     │
                            ▼                     ▼
                     ┌─────────────┐       ┌────────────────┐
                     │   Iceberg   │       │   PostgreSQL   │
                     │ (data lake) │       │ (operational)  │
                     └─────────────┘       └────────────────┘
```

- **Kafka** decouples producers from consumers, allowing new destinations to be added without touching the ingestion layer.
- **PostgreSQL** holds structured per-device tables (People_Counter, Environmental_Monitoring, etc.) for low-latency BI queries.
- **Apache Iceberg** captures the full event history and supports time-travel queries for trend and incident analysis.

## Technologies

`Python` · `Paho-MQTT` · `Confluent Kafka` · `PostgreSQL` · `Apache Iceberg` · `Docker` · `Linux`

## Methodology

1. **Discovery.** Cataloged sensor types, message schemas, and downstream consumer needs.
2. **Schema design.** Defined a normalized table per device category and a canonical Kafka event envelope (`timestamp`, `device_*`, `sensor_readings`).
3. **Streaming layer.** Built a Paho-MQTT producer that validates, timestamps, and forwards events to Kafka.
4. **Sink layer.** Built a Kafka consumer that categorizes each device, maps it to the correct PostgreSQL table, and writes with rollback on failure.
5. **Long-term storage.** Routed the same Kafka topic to Apache Iceberg for historical analysis.
6. **Deployment.** Containerized the full stack with Docker Compose on a remote Linux server.

## Key Results

| Metric | Improvement |
| --- | --- |
| Malformed / lost records | **−30%** through validation + error recovery |
| Query performance | **+40%** vs. JSON-in-Postgres baseline |
| New consumers added | Without downtime to existing producers |
| Historical analysis | Enabled via Iceberg time-travel |

## Repository Structure

```
Iot Sensors/
├── README.md          # This file
└── (architecture & dashboards referenced in /Python/IoT Data Pipeline)
```

The Python scripts that power this pipeline live in [`/Python/IoT Data Pipeline`](../../Python/IoT%20Data%20Pipeline).

## Architecture & Dashboards

<img width="1536" alt="Architecture diagram" src="https://github.com/user-attachments/assets/5e45761c-f659-40ee-bc2f-143658e56575" />

<img width="1915" alt="Kafka topic monitoring" src="https://github.com/user-attachments/assets/25aa26dc-d129-4801-85aa-808dad9bd737" />

<img width="1916" alt="Live ingestion" src="https://github.com/user-attachments/assets/dc687ef2-eac9-4ba7-b7bf-a4f7d6578a30" />

<img width="837" alt="Operational dashboard" src="https://github.com/user-attachments/assets/8634d2ff-47fd-4d72-8642-cbed3f0d05f8" />

<img width="837" alt="Historical analysis" src="https://github.com/user-attachments/assets/a4c908ec-90c2-4e21-a617-aa273ca45608" />

<img width="866" alt="Iceberg time travel" src="https://github.com/user-attachments/assets/e47b5531-764e-4b36-917c-23cb36c8364a" />

## Future Improvements

- **Schema registry** (Confluent Schema Registry) for enforced contract evolution.
- **Stream processing** with Kafka Streams or Flink for in-flight aggregation.
- **Observability** via Prometheus + Grafana with consumer-lag alerting.
- **CI/CD** for declarative deployment of Docker stacks.
- **Authentication & TLS** for MQTT and Kafka in production.

---

**Author:** Enmanuel Mateo · [GitHub](https://github.com/EnmanuelMateo) · [LinkedIn](https://www.linkedin.com/)
