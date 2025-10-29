import json
import time
import logging
import paho.mqtt.client as mqtt
from confluent_kafka import Producer
from datetime import datetime

# Kafka configuration
kafka_conf = {
    'bootstrap.servers': 'localhost:0000',  # Update if using Docker or remote Kafka
}
kafka_producer = Producer(kafka_conf)

# MQTT configuration
mqtt_host = "your_own"
mqtt_port = 00000
mqtt_topic = "your_own"

# Function to process MQTT messages
def process_mqtt_message(client, userdata, message):
    try:
        payload = message.payload.decode("utf-8")
        data = json.loads(payload)

        # Capture timestamp at message retrieval
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Extract relevant device details
        device_type = data.get("device_info", {}).get("device_type", "Unknown Type")
        device_name = data.get("device_info", {}).get("device_name", "Unknown Name")
        device_eui = data.get("device_info", {}).get("device_eui", "Unknown Eui")
        location = data.get("device_info", {}).get("device_deployment_location", "Unknown Location")
        sublocation = data.get("device_info", {}).get("device_deployment_sub_location", "Unknown Sublocation")

        # Extract sensor readings safely
        sensor_readings = data.get("device_info", {}).get("sensor_info", [])
        sensor_id = sensor_readings[0].get("sensor_id", "Unkown Sensor_ID")

        # Prepare structured data for Kafka
        cleaned_data = {
            "timestamp": timestamp,
            "device_type": device_type,
            "device_name": device_name,
            "device_eui": device_eui,
            "location": location,
            "sublocation": sublocation,
            "sensor_id": sensor_id,
            "sensor_readings": sensor_readings
        }

        # Convert cleaned data to JSON
        kafka_message = json.dumps(cleaned_data, ensure_ascii=True).encode('utf-8')

        # Send message to Kafka
        kafka_producer.produce('sensor_data', key=str(time.time()), value=kafka_message)
        kafka_producer.flush()

        print(f"\nSent to Kafka: {cleaned_data}")

    except json.JSONDecodeError as e:
        logging.error(f"JSON decoding error: {e}")
    except Exception as e:
        logging.error(f"Unexpected error processing MQTT message: {e}")

# Set up MQTT client
mqtt_client = mqtt.Client(client_id="Kafka_MQTT")
mqtt_client.on_message = process_mqtt_message  # Assign before connecting
mqtt_client.connect(mqtt_host, mqtt_port)

# Start MQTT listener
mqtt_client.loop_start()
mqtt_client.subscribe(mqtt_topic)

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Shutting down MQTT client gracefully...")
    mqtt_client.loop_stop()
    kafka_producer.flush()
    mqtt_client.disconnect()



