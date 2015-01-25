#include <Stepper.h>

// Based off Chat  Server
/* Based off chat server */
#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper(stepsPerRevolution, 22,23,24,25);            
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
  myStepper.setSpeed(60); 
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
      
      myStepper.step(steps);
      
    }
  }
  
  client.stop();
}

