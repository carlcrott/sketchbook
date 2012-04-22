// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

#include <Servo.h>
Servo myservo;  // create servo object to control a servo 
 
int potpin = 2;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin 
int pos = 0;    // variable to store the servo position
 
void setup() 
{ 
  pinMode(potpin, OUTPUT);  // declare the ledPin as an OUTPUT
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  Serial.begin(9600);
//  myservo.write(pos);
//  delay(4000);
} 
 
void loop() 
{ 
  val = analogRead(potpin);
  
  if (pos == 0){
    Serial.println("extending");
    myservo.write(HIGH);
    Serial.println(val);
  }
  

//  if (pos == 800){
//    Serial.println("extending");
//    myservo.write(0);
//    Serial.println(analogRead(potpin));
//  }

  delay(500);
} 
