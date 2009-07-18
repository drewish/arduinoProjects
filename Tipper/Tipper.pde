/*
 Uses an adafruit industries accelleration sensor on analog pins 9-11 and ouputs to LEDs on
 pins 2-4.
 */

struct axis {
  unsigned int accelPin;
  unsigned int ledPin;
  int value;
};
axis x, y, z;


void setup() {
  Serial.begin(9600);
  
  // Setup the axis info
  x.accelPin = 0;
  y.accelPin = 1;
  z.accelPin = 2;

  x.ledPin = 2;
  y.ledPin = 3;
  z.ledPin = 4;
}

void loop() {
  x.value = analogRead(x.accelPin);
  y.value = analogRead(y.accelPin);
  z.value = analogRead(z.accelPin);
  
  // Compute a parity value so we catch corrupt packets.
  int parity = (x.value + y.value + z.value) % 10;

  Serial.print(x.value, DEC); 
  Serial.print(","); 
  Serial.print(y.value, DEC);
  Serial.print(","); 
  Serial.print(z.value, DEC);
  Serial.print(","); 
  Serial.println(parity, DEC);
}
