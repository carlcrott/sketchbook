
int actuator = 9;    // LED connected to digital pin 9
int potpin = 2;  // analog pin used to connect the potentiometer
int initer = 0;

// extended:
// 34, 35, 36, 38

// contracted:
// 767, 769, 770, 771


void setup()  { 
  Serial.begin(9600);
  Serial.println("zeroing");
  analogWrite(actuator, 100);
  delay(4000);
} 

void loop()  {
 
  
//  Serial.println("extending");
//  // fade in from min to max in increments of 5 points:
//  for(int fadeValue = 140 ; fadeValue <= 255; fadeValue +=5) { 
//    // sets the value (range from 0 to 255):
//    analogWrite(actuator, fadeValue);         
//    Serial.println(analogRead(potpin));   
//    delay(220);                            
//  } 
//
//  Serial.println("contracting");
//  // fade out from max to min in increments of 5 points:
//  for(int fadeValue = 255 ; fadeValue >= 80; fadeValue -=5) { 
//    // sets the value (range from 0 to 255):
//    analogWrite(actuator, fadeValue);         
//    Serial.println(analogRead(potpin));   
//    delay(220);                            
//  } 
//  
}


