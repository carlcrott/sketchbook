/*
 Fading
 
 This example shows how to fade an LED using the analogWrite() function.
 
 The circuit:
 * LED attached from digital pin 9 to ground.
 
 Created 1 Nov 2008
 By David A. Mellis
 modified 30 Aug 2011
 By Tom Igoe
 
 http://arduino.cc/en/Tutorial/Fading
 
 This example code is in the public domain.
 
 34 - 766 
 
 */


int ledPin = 9;    // LED connected to digital pin 9
int potpin = 2;  // analog pin used to connect the potentiometer
int initer = 0;

void setup()  { 
  Serial.begin(9600); 
} 

void loop()  {
  
  if(initer == 0){
    for(int fadeValue = 255 ; fadeValue >= 80; fadeValue -=5) { 
      analogWrite(ledPin, fadeValue);
      delay(220);
    }
    delay(2000);
    initer = 1;
  }
  
  void placeActuator(int x, int y){
    analogWrite(pin, dutyCycle);
  
  }
  
  Serial.println("extending");
  // fade in from min to max in increments of 5 points:
  for(int fadeValue = 140 ; fadeValue <= 255; fadeValue +=5) { 
    // sets the value (range from 0 to 255):
    analogWrite(ledPin, fadeValue);         
    Serial.println(analogRead(potpin));   
    delay(220);                            
  } 

  Serial.println("contracting");
  // fade out from max to min in increments of 5 points:
  for(int fadeValue = 255 ; fadeValue >= 80; fadeValue -=5) { 
    // sets the value (range from 0 to 255):
    analogWrite(ledPin, fadeValue);         
    Serial.println(analogRead(potpin));   
    delay(220);                            
  } 
  
}


