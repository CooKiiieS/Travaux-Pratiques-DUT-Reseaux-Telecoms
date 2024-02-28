void setup() {
  Serial.begin(115200);

}

void loop() {
  float tension = analogRead(A0);
  float tension2 = (tension * 5) / 1024;
  Serial.print("Tension : ");
  Serial.print(tension2);
  Serial.print(" V");
  Serial.print("\n");
  Serial.print("-------------");
  Serial.print("\n");
  delay(2000);
}
