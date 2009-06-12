
struct axis {
  int accelPin;
  int ledPin;
  int value;
  int abs;
};
axis x, y, z;
int offset;

void setup() {
  Serial.begin(57600);

  // Setup the axis info
  x.accelPin = 0;
  y.accelPin = 1;
  z.accelPin = 2;

  x.ledPin = 9;
  y.ledPin = 10;
  z.ledPin = 11;

  // Now calibrate the sensors. If we're flat one will dominate.
  digitalWrite(x.ledPin, HIGH);
  digitalWrite(y.ledPin, HIGH);
  digitalWrite(z.ledPin, HIGH);
  
  delay(100);
  sample();
Serial.println(x.value, DEC);
Serial.print("X-val:"); Serial.println(x.value, DEC);
Serial.print("Y-val:"); Serial.println(y.value, DEC);
Serial.print("Z-val:"); Serial.println(z.value, DEC);
  
  int median = max(min(x.value, y.value), min(y.value, z.value));
Serial.print("median:"); Serial.println(median, DEC);
  offset = median;
/*  
  x.offset = median - x.value;
  y.offset = median - y.value;
  z.offset = median - z.value;
Serial.print("X-off:"); Serial.println(x.offset, DEC);
Serial.print("Y-off:"); Serial.println(y.offset, DEC);
Serial.print("Z-off:"); Serial.println(z.offset, DEC);
*/
  sample();

}

void loop() {
  sample();

  if (x.abs > y.abs && x.abs > z.abs) {
    digitalWrite(x.ledPin, HIGH);
    digitalWrite(y.ledPin, LOW);
    digitalWrite(z.ledPin, LOW);
  }
  if (y.abs > x.abs && y.abs > z.abs) {
    digitalWrite(x.ledPin, LOW); 
    digitalWrite(y.ledPin, HIGH); 
    digitalWrite(z.ledPin, LOW); 
  }
  if (z.abs > x.abs && z.abs > y.abs) {
    digitalWrite(x.ledPin, LOW); 
    digitalWrite(y.ledPin, LOW); 
    digitalWrite(z.ledPin, HIGH); 
  }
}

void sample() {
  x.value = map(analogRead(x.accelPin), 0, 640, -320, 320);
  y.value = map(analogRead(y.accelPin), 0, 640, -320, 320);
  z.value = map(analogRead(z.accelPin), 0, 640, -320, 320);
  x.abs = abs(x.value) - offset;
  y.abs = abs(y.value) - offset;
  z.abs = abs(z.value) - offset;
  
Serial.print("X-val:"); Serial.print(x.value, DEC);
Serial.print(" Y-val:"); Serial.print(y.value, DEC);
Serial.print(" Z-val:"); Serial.print(z.value, DEC);
Serial.print("\tX-abs:"); Serial.print(x.abs, DEC);
Serial.print(" Y-abs:"); Serial.print(y.abs, DEC);
Serial.print(" Z-abs:"); Serial.println(z.abs, DEC);

}
