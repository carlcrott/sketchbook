#include <Stepper.h>

// Based off Chat  Server
/* Based off chat server */
#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper01(stepsPerRevolution, 4,5,6,7);
//Stepper myStepper02(stepsPerRevolution, 26,27,28,29);
//Stepper myStepper03(stepsPerRevolution, 30,31,32,33);
//Stepper myStepper04(stepsPerRevolution, 34,35,36,37);
int stepCount = 0;

char* thisVal;

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192,168,0, 145 };


// telnet defaults to port 23
Server server(23);
boolean gotAMessage = false; // whether or not you got a message from the client yet

void setup() {
  // initialize the ethernet device
  Ethernet.begin(mac, ip);
  // start listening for clients
  server.begin();
  // open the serial port
  Serial.begin(9600);
  // set the speed at 60 rpm:
  myStepper01.setSpeed(60); 
  //myStepper02.setSpeed(60);
  //myStepper03.setSpeed(60); 
  //myStepper04.setSpeed(60);
}

void loop() {
  // wait for a new client:
  Client client = server.available();

  // when the client sends the first byte, say hello:
  if (client) {

    if (client.available() >= 3 ) { // movement command has stepperID int sign and a value
      char id = client.read(); 
      int steps = client.read() | (client.read() << 8);
      
      Serial.println(id);
      Serial.println(steps);
      
      if (id == 0){
        client.stop();
        Serial.println("STOP!");
      }
      
      if (id == 1){
        myStepper01.step(steps);
      }
      if (id == 2){
        //myStepper02.step(steps);
      }
      if (id == 3){
        //myStepper03.step(steps);
      }
      if (id == 4){
        //myStepper04.step(steps);
      }
      
      
    }
  }
}

