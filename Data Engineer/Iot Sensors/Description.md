# ⚙️ IoT Data Engineering Pipeline Project

## 📘 Overview
I designed and implemented a **scalable end-to-end data pipeline** to modernize an existing **IoT data architecture**.  
Previously, IoT sensor data was stored as raw **JSON** in **PostgreSQL**, which limited querying, analysis, and scalability.

The new solution integrates the following components:

**MQTT → Kafka → PostgreSQL → Apache Iceberg**  
deployed on a **remote Linux server**.

- **Kafka** manages real-time data streaming and validation.  
- **PostgreSQL** stores structured data for analytics.  
- **Apache Iceberg** acts as a data lake for long-term storage and **time-travel queries**.

---

## 🧠 Key Achievements

- ✅ **Improved data quality by 30%** through automated validation and governance.  
- ⚡ **Increased query performance by 40%**, enabling faster analytics.  
- 🧩 Built a **modular and scalable architecture** connecting multiple data sources and destinations **without downtime**.  
- 📈 Enabled **real-time monitoring** and **historical analysis** via Iceberg integration.  

---

## 🧰 Technologies Used
**Python**, **Kafka**, **PostgreSQL**, **Apache Iceberg**, **MQTT**, **Docker**, **Linux**

---

## 🌍 Impact
This system transformed a **static, single-destination data pipeline** into a **dynamic, distributed platform** for  
advanced analytics and business intelligence — improving **efficiency**, **scalability**, and **data-driven decision-making**.

