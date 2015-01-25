#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper(stepsPerRevolution, 22,23,24,25);   
#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x30, 0x93 };
byte ip[] = { 192, 168, 0, 145 };
byte server[] = { 192,168,0,110 };
byte mybuffer[50];

byte arg[12];
char id;
int steps;

Client client(server, 5001);

void setup() {
  Ethernet.begin(mac, ip);
  myStepper.setSpeed(60);
  Serial.begin(9600);
  delay(500);
  Serial.println("connecting...");

  // if you get a connection, report back via serial:
  if (client.connect()) {
    Serial.println("connected");   
  } 
  else {
    Serial.println("connection failed"); //FAILED CONNECT
  }
}

void loop()
{
  if (client.available())  { // movement command has stepperID int sign and a value
    
    char id = client.read();
    
    Serial.println(id);
    Serial.println(steps);
    
    //myStepper.step(steps);
    
    /*
    for(int foo = 0; foo < 6; foo++){
      arg[foo] = client.read();
      Serial.println(arg[foo]);
    }
    
    delay(1000);
    */
  }

  // if the server's disconnected, stop the client:
  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    for(;;);
  }
}


