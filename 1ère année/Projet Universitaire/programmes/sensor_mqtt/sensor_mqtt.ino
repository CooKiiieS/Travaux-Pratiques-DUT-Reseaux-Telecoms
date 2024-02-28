// --- SI7021
#include <Adafruit_Si7021.h>
Adafruit_Si7021 sensor = Adafruit_Si7021();

// --- MQTT
#include <Ethernet.h>
#include <MQTT.h>

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
byte ip[] = {10, 206, 0, 148};  // <- change to match your network

EthernetClient net;
MQTTClient client;

void connect() {
  Serial.print("connecting...");
  while (!client.connect("arduino", "try", "try")) {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("\nconnected!");

  client.subscribe("#");
  // client.unsubscribe("/hello");
}

void messageReceived(String &topic, String &payload) {
  Serial.println("incoming: " + topic + " - " + payload);
}

void setup() {
  Serial.begin(115200);


  // --- SI7021
  while (!Serial) {
    delay(10);
  }
  if (!sensor.begin()) {
    while (true);
  }

  // --- MQTT
  Ethernet.begin(mac, ip);

  // Note: Local domain names (e.g. "Computer.local" on OSX) are not supported by Arduino.
  // You need to set the IP address directly.
  client.begin("10.206.0.145", net);
  client.onMessage(messageReceived);

  connect();
}

void loop() {
  // --- SI7021
  float hum = sensor.readHumidity();
  float celsTemp = sensor.readTemperature();
  double celsGamma = log(hum / 100) + ((17.62 * celsTemp) / (243.5 + celsTemp));
  double celsRosee = 243.5 * celsGamma / (17.62 - celsGamma);

  float fahrTemp = celsTemp * 1.8 + 32;
  double fahrGamma = log(hum / 100) + ((17.62 * fahrTemp) / (243.5 + fahrTemp));
  double fahrRosee = 243.5 * fahrGamma / (17.62 - fahrGamma);

  // --- SCT013
  float tension = analogRead(A0);
  float tension2 = (tension * 5) / 1024;
  Serial.print("Tension : ");
  Serial.print(tension2);
  Serial.print(" V");
  Serial.print("\n");
  Serial.print("Humidité : ");
  Serial.print(hum);
  Serial.print(" %");
  Serial.print("\n");
  Serial.print("Température °C : ");
  Serial.print(celsTemp);
  Serial.print(" °C");
  Serial.print("\n");
  Serial.print("Température °F: ");
  Serial.print(fahrTemp);
  Serial.print(" °F");
  Serial.print("\n");
  Serial.print("Point de rosée °C: ");
  Serial.print(celsRosee);
  Serial.print(" °C");
  Serial.print("\n");
  Serial.print("Point de rosée °F: ");
  Serial.print(fahrRosee);
  Serial.print(" °F");
  Serial.print("\n");
  Serial.print("-------------");
  Serial.print("\n");
  delay(2000);
  char volt[10];
  char humid[10];
  char ctmp[10];
  char ftmp[10];
  char crse[10];
  char frse[10];

  dtostrf(tension2, 2, 3, volt);
  dtostrf(hum, 2, 3, humid);
  dtostrf(celsTemp, 2, 3, ctmp);
  dtostrf(fahrTemp, 2, 3, ftmp);
  dtostrf(celsRosee, 2, 3, crse);
  dtostrf(fahrRosee, 2, 3, frse);
  client.loop();

  if (!client.connected()) {
    connect();
  }
    client.publish("projet/si7021a/humidite", humid);

  client.publish("projet/sct013/tension", volt);

  client.publish("projet/si7021a/ctemp", ctmp);

  client.publish("projet/si7021a/ftemp", ftmp);

  client.publish("projet/si7021a/crosee", crse);

  client.publish("projet/si7021a/frosee", frse);

  delay(2000);
}
