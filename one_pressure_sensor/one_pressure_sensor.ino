
// analog pin 0 for touch sensor
#define PRESSURE_SENSOR_PIN 0   
int Pressure = 0;         

void setup() 
{
 // initialize the serial communications:
 Serial.begin(9600);
}

void loop() 
{

Pressure = analogRead(PRESSURE_SENSOR_PIN); // read touch sensor
Serial.println(Pressure);
delay(50);

}
