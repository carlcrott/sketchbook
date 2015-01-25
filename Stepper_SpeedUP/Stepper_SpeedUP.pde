// Based off Stepper Motor Control - one step at a time

#include <Stepper.h>
const int stepsPerRevolution = 200;  // change this to fit the number of steps per revolution

Stepper myStepper(stepsPerRevolution, 22,23,24,25);            

int stepCount = 0;         // number of steps the motor has taken

void setup() {
  // initialize the serial port:
  Serial.begin(9600);
  myStepper.setSpeed(60);
}

void loop() {
  // step one step:
  myStepper.step(200);
  Serial.print("steps:" );
  Serial.println(stepCount);
  stepCount++;
  //delay(500);


  if (stepCount > 5){
    Serial.println("running at 80");
    myStepper.setSpeed(160);
  }
}

