// MultiStepper.pde Copyright (C) 2009 Mike McCauley
#include <AccelStepper.h>

// Define some steppers and the pins the will use
AccelStepper plateDriver(1,46,47); // "1" specifys mode of, step, direction

int SLEEP = 45;

void setup(){
  Serial.begin(9600);
    // setup of plateDriver
  plateDriver.setMaxSpeed(800.0);
  plateDriver.setAcceleration(600.0);
  pinMode(SLEEP, INPUT);
//  digitalWrite(SLEEP, LOW);
 
}

void loop(){
   plateDriver.move(2000);
   plateDriver.runToPosition();            //rotate plate driver foward
   Serial.println("running");
   
   plateDriver.move(-2000);
   plateDriver.runToPosition();            //rotate plate driver foward
   Serial.println("running backwards");
}
