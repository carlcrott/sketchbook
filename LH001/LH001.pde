#include <SPI.h>
#include <Ethernet.h>
#include <AccelStepper.h> // MultiStepper.pde Copyright (C) 2009 Mike McCauley

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192,168,0, 145 };

// telnet defaults to port 23
Server server(23);
boolean gotAMessage = false; // whether or not you got a message from the client yet

// Define some steppers and the pins the will use
AccelStepper plateDriver(1,22,23); // "1" specifys mode of, step, direction
int MS1 = 24;
int MS2 = 25;
int SLEEP = 26;
AccelStepper pump(4, 6, 7, 8, 9); // "4" specifys bipolar w the 4 pins following
int ledPin = 53;                // choose the pin for the LED

  // front opto interruptor
int optoInterruptorFront = 49;               // choose the input pin
int optoInterruptorFrontVal = 0;             // variable for reading the pin status
// rear opto interruptor
int optoInterruptorRear = 48;               // choose the input pin
int optoInterruptorRearVal = 0;             // variable for reading the pin status

boolean initalZeroFront = false;
boolean zeroedRear = false;

void setup(){
    // initialize the ethernet device
  Ethernet.begin(mac, ip);
    // start listening for clients
  server.begin();
  Serial.begin(9600);
  pinMode(optoInterruptorFront, INPUT);     // declare optoInterruptorFront as input
  pinMode(optoInterruptorRear, INPUT);     // declare optoInterruptorRear as input
    // setup of plateDriver
  plateDriver.setMaxSpeed(800.0);
  plateDriver.setAcceleration(600.0);
  pinMode(MS1, OUTPUT);   // set pin 24 to output
  pinMode(MS2, OUTPUT);   // set pin 25 to output
  pinMode(SLEEP, OUTPUT); // set pin 26 to output
  digitalWrite(MS1, LOW);
  digitalWrite(MS2, LOW);
  digitalWrite(SLEEP, HIGH);
    //setup of peristaltic pump stepper 
  pump.setMaxSpeed(300.0);
  pump.setAcceleration(100.0);
  //pump.moveTo(10000);
}

void loop(){
    // waits for a new client:
  Client client = server.available();
  if (client) {
    if (client.available() >= 3 ) {
        // value of 1 begins dispense sequence
      char id = client.read(); 
        // reserved for future use for rails control up to 10000 steps
      int steps = client.read() | (client.read() << 8);
      
      if (id == 0){
        client.stop();
        Serial.println("STOP!");
      }
      
      if (id == 1){ 
        optoInterruptorFrontVal = digitalRead(optoInterruptorFront);  // read input value
        optoInterruptorRearVal = digitalRead(optoInterruptorRear);  // read input value
      
        while(initalZeroFront == false){
          Serial.println(optoInterruptorFrontVal);
            // Initial zeroing
          while(optoInterruptorFrontVal == HIGH){      // if front opto is HIGH... move stage towards front
            // xxxxxxx  First Movement ... use to position stage xxxxxx
            // default value should be -1 to allow step-by-step zeroing of the stage
            plateDriver.move(-1000000);
            plateDriver.runToPosition();            //rotate plate driver foward
            optoInterruptorFrontVal = digitalRead(optoInterruptorFront);
            Serial.println("zeroing forward");
          }
          initalZeroFront = true;
          Serial.println("ZEROED forward");
            // this is when plate would be placed on the stage
          delay(1000);
    
        }
        // plate resides at front most position
        // zeroedFront == true at this point
    
        frontZeroedTowardsDispenseZero();
        // plate resides directly under dispensing pipettes
    
        dispenseLoop();
        // microplate filled
    
        returnPlateFront();
      }
    }
  }  
}

  
  void frontZeroedTowardsDispenseZero() {
    Serial.println("massive move backwards");
    plateDriver.move(45000);
    plateDriver.runToPosition();
  
      // rear zeroing process
    while(optoInterruptorRearVal == HIGH){
      plateDriver.move(1);
      plateDriver.runToPosition();            //rotate plate driver foward
      optoInterruptorRearVal = digitalRead(optoInterruptorRear);
      Serial.println("zeroing back");
    }
    Serial.println("ZEROED under pipettes");
    delay(5000);
  
  }
  
  void dispenseLoop(){
    for(int i = 0; i < 13; i++){
          // rewrite these as non-blocking
      Serial.println(i);
  
      Serial.println("dispensing " + i);
        // dispense X volume of liquid
      pump.move(100);
      pump.runToPosition();
  
      Serial.println("advancing");
        // move plate to next well
      plateDriver.move(-1000);
      plateDriver.runToPosition();
  
      delay(500);
      
      
      
    }
    Serial.println("done dispensing");
  }
  
  void returnPlateFront(){
    Serial.println("massive move forwards");
    plateDriver.move(-30000);
    plateDriver.runToPosition();
    
     // front zeroing process
    while(optoInterruptorFrontVal == HIGH){
      plateDriver.move(-1);
      plateDriver.runToPosition();            //rotate plate driver foward
      optoInterruptorFrontVal = digitalRead(optoInterruptorFront);
      Serial.println("zeroing front loop");
    }
    
    Serial.println("ZEROED at front");
    
    for (int i = 0; i < 100; i++){
      Serial.println("done");
      delay(500);
    }
  }
