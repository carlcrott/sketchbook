// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

#include <Servo.h>
#include <Stepper.h>

const int stepsPerRevolution = 2000;  // change this to fit the number of steps per revolution
Stepper myStepper(stepsPerRevolution, 8,9); 
 
Servo actuator;  // create servo object to control a servo 
 
int potpin = 2;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin 
 
void setup() 
{ 
  pinMode(potpin, OUTPUT);  // declare the ledPin as an OUTPUT
  actuator.attach(9);  // attaches the servo on pin 9 to the servo object 
  Serial.begin(9600);
} 
 
void loop() 
{ 
  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 888) 

  myStepper.step(stepsPerRevolution);
  Serial.println(val);
  delay(400);                           // waits for the servo to get there 
} 
