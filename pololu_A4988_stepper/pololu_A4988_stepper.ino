#include <AccelStepper.h>
#include <Stepper.h>

const int stepsPerRevolution = 200;  // change this to fit the number of steps per revolution
                                     // for your motor

//                    (mode, step, dir)
AccelStepper myStepper1(1,4,5);
AccelStepper myStepper2(1,6,7);
//Stepper myStepper(stepsPerRevolution, 8,9,10,11);            

void setup() {
  myStepper1.setMaxSpeed(200.0);
  myStepper1.setAcceleration(200.0);
  myStepper2.setMaxSpeed(200.0);
  myStepper2.setAcceleration(200.0);
  // initialize the serial port:
  Serial.begin(9600);
}

void loop() {
  // step one revolution  in one direction:
   Serial.println("clockwise");
  //myStepper.step(stepsPerRevolution);
  myStepper1.move(stepsPerRevolution);
  myStepper2.move(stepsPerRevolution);
  myStepper1.runToPosition();
  myStepper2.runToPosition();
  delay(500);
  
   // step one revolution in the other direction:
  Serial.println("counterclockwise");
  myStepper1.move(-stepsPerRevolution);
  myStepper2.move(-stepsPerRevolution);
  myStepper1.runToPosition();
  myStepper2.runToPosition();
  delay(500); 
}
