/*
ADXL335
note:vcc-->5v ,but ADXL335 Vs is 3.3V
The circuit:
      5V: VCC
analog 1: x-axis
analog 2: y-axis
analog 3: z-axis

analog 0: touch sensor, with 4,7k resistor

motor is connexted on pin 7 (IN2), 8 (IN1) and 9 (ENA)
*/

int MotorSpeed = 200;
int Pressure = 0;         
#define ADXL_XPIN 1          /* x-axis of the accelerometer */
#define ADXL_YPIN 2          /* y-axis */
#define ADXL_ZPIN 3          /* z-axis (only on 3-axis models) */
// motor controller pins
#define MOTOR_ENA 9
#define MOTOR_IN1 8
#define MOTOR_IN2 7
// analog pin 0 for touch sensor
#define PRESSURE_SENSOR_PIN 0   

void setup()
{
 // initialize the serial communications:
 Serial.begin(9600);
}

void loop()
{
 int x = analogRead(ADXL_XPIN);  //read from ADXL_XPIN
 
 int y = analogRead(ADXL_YPIN);  //read from ADXL_YPIN
 
 int z = analogRead(ADXL_ZPIN);  //read from ADXL_ZPIN
 
float zero_G = 512.0; //ADC is 0~1023  the zero g output equal to Vs/2
                      //ADXL335 power supply by Vs 3.3V
float scale = 102.3;  //ADXL335330 Sensitivity is 330mv/g
                       //330 * 1024/3.3/1000  
Pressure = analogRead(PRESSURE_SENSOR_PIN); // read touch sensor
 
/*Serial.print(x); 
Serial.print("\t");
Serial.print(y);
Serial.print("\t");
Serial.print(z);  
Serial.print("\n");*/
Serial.print(((float)x - 331.5)/65*9.8);  //print x value on serial monitor
Serial.print("\t");
Serial.print(((float)y - 329.5)/68.5*9.8);  //print y value on serial monitor
Serial.print("\t");
Serial.print(((float)z - 340)/68*9.8);  //print z value on serial monitor
Serial.print("\t");
Serial.print(Pressure);
Serial.print("\n");

if (y > 8)    // that means bellow is too empty, 8 would be parallel
  {
    if (MotorSpeed > 0) MotorSpeed =-10;
  }
  else
  {
    if (MotorSpeed < 250) MotorSpeed =+ 10;
  }

digitalWrite(MOTOR_IN1, HIGH);
digitalWrite(MOTOR_IN2, LOW);
analogWrite(MOTOR_ENA, MotorSpeed);

delay(500);
}