// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
                
int potpin = 2;  // analog pin used to connect the potentiometer
int pos = 0;    // variable to store the servo position
int val = 0;         // variable to store the read value
 
 
 
void setup() 
{ 
  pinMode(potpin, OUTPUT);  // declare the potpin as an OUTPUT
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  Serial.begin(9600);
} 
 
 
void loop() 
{ 
//  Serial.println("extending");
//  for(pos = 0; pos < 255; pos += 1){
//    analogWrite(ledPin, pos);  // analogRead values go from 0 to 1023, analogWrite values from 0 to 255
//  }
//  Serial.println("pausing");
//  delay(4000);
//  
//  Serial.println("contracting");
//  for(pos = 0; pos < 255; pos += 1){
//    analogWrite(ledPin, -pos);  // analogRead values go from 0 to 1023, analogWrite values from 0 to 255
//  }
  
  
  Serial.println("extending");
  for(pos = 0; pos < 255; pos += 1)  // goes from 0 degrees to 180 degrees 
  {                                  // in steps of 1 degree 
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);                       // waits 15ms for the servo to reach the position
    Serial.println(analogRead(potpin));
  }
  

  delay(4000);
  
  Serial.println("contracting");
  for(pos = 255; pos>=1; pos-=1)     // goes from 180 degrees to 0 degrees 
  {                                
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);                       // waits 15ms for the servo to reach the position
    Serial.println(analogRead(potpin)); 
  } 


  Serial.println("end");
  delay(4000);
  
} 
