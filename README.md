# 🗺 Enmanuel's Portfolio

Welcome to my Data Portfolio!
Here, I document my projects in Data Analysis, Data Engineering, and Visualization — showcasing my passion for turning raw data into insights that drive decisions.

# 📚 Table of Contents

 - [Data Engineering](#data-engineer)
 - SQL
 - Python
 - Power BI


<a name="data-engineer"></a>
# 🏗 Data Engineering

| Project                              | Completion Date | Tools                            | Description                                                                                                                                                      |
| ------------------------------------ | --------------- | -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🚛 Iot Sensors Pipeline               | Sep 2025        | Python, Kafka, PostgreSQL, Apache Iceberg, MQTT, Docker, Linux | Designed and implemented a scalable end-to-end data pipeline to modernize IoT data architecture. Integrated MQTT → Kafka → PostgreSQL → Apache Iceberg, improving data quality by 30%, query performance by 40%, and enabling real-time monitoring and historical analysis. Built a modular architecture capable of connecting multiple data sources without downtime. |

# 🧠 SQL

| Project                     | Area of Analysis       | Description                                                                                                     |
| --------------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------- |
| 💳 Fraud Detection Analysis | Financial Transactions | Detected suspicious card transactions under $2 using SQL and Python; identified top 5 vulnerable merchants.     |
| 🧾 Sales Insights Querying  | Retail Analytics       | Wrote optimized SQL queries to extract sales insights and measure performance across regions.                   |
| 🧰 Data Cleaning/Schema Challenges | Data Preparation       | Solved SQL challenges involving data wrangling, cleaning, and transformation to prepare datasets for reporting. |

# 🐍 Python

| Project                                    | Area                   | Description                                                                                                                                                                                                                                                                                                                                | Libraries                                                     |
| ------------------------------------------ | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------- |
| 🌐 IoT Data Pipeline (Producer & Consumer) | Data Engineering / IoT | Developed Python scripts to connect to an MQTT broker and extract IoT sensor data. The producer script collects and cleans data, sending it to Kafka via Docker. The consumer script organizes the streamed data and loads it into PostgreSQL for analysis. Enabled scalable, real-time processing and integration with the data pipeline. | json, logging, psycopg2, psycopg2.extras (Json), confluent_kafka, os, time, datetime |
| 💳 Fraud Detection Analysis | Financial Transactions | Analyzed and cleaned transaction data, searched for outliers, and visualized insights to detect suspicious card activity. | pandas, SQLAlchemy, seaborn, matplotlib |



# 📊 Power BI

| Project                                       | Description                                                                                                                                                                                                                                                                                                                                                                                  | Dashboard      |
| --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| 🏔 AdventureWorks Sales Performance Dashboard | Analyzed sales, profit, and customer trends from 2020–2022, revealing $24.9M in revenue, $10.5M in profit, and 25.2K orders with a low 2.2% return rate. Built using Power BI Desktop, DAX calculations, and data modeling techniques, highlighting revenue growth, 42% profit margin, and top-performing products. Insights enable targeted marketing and customer segmentation.            | View Dashboard |
| 🛒 Maven Market Sales Dashboard               | Evaluated brand performance, profitability, and regional activity across the USA, Mexico, and Canada for 1998. Tracked 112,433 transactions generating $449K in profit with 1% return ratio. Monthly profit $71.68K surpassed goals by 5.61%. Built using Power BI Desktop and DAX, providing insights to enhance marketing, improve brand partnerships, and identify underperforming areas. | View Dashboard |
