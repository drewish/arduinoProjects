/*
 * Reflect serial input back.
 */
void setup()
{
  Serial.begin(9600);
}

void loop()
{
  while (Serial.available() > 0) {
    Serial.write(Serial.read());
  }
}
