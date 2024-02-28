// --- SI7021
#include <Adafruit_Si7021.h>
Adafruit_Si7021 sensor = Adafruit_Si7021();

void setup() {
  Serial.begin(115200);


  // --- SI7021
  while (!Serial) {
    delay(10);
  }
  if (!sensor.begin()) {
    while (true);
  }
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
}
