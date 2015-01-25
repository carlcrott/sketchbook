#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper(stepsPerRevolution, 22,23,24,25);   
#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x30, 0x93 };
byte ip[] = { 192, 168, 0, 145 };
byte server[] = { 192,168,0,110 };
byte mybuffer[50];
size_t c;

// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP):
Client client(server, 6789);

void setup() {
  Ethernet.begin(mac, ip);
  myStepper.setSpeed(60);
  Serial.begin(9600);
  delay(500);
  Serial.println("connecting...");

  // if you get a connection, report back via serial:
  if (client.connect()) {
    Serial.println("connected");
    //client.println("GET /search?q=arduino HTTP/1.0");
    //myStepper.step(stepsPerRevolution);
    //byte motor = client.read();
    //client.print(motor);
    //client.print("herro");
  } 
  else {
    Serial.println("connection failed"); //FAILED CONNECT
  }
}

void loop()
{
  if (client.available()) { // movement command has stepperID int sign and a value
    c = client.read(mybuffer,4);
    //Serial.print(mybuffer[c]);
    //delay(500);
    
    // multibyte read ... but then have to step through the buffer to print it
    for(int foo = 0; foo < c; foo++){
      Serial.print(mybuffer[foo]);
    }

    //char movement = client.read() | (client.read() << 8); // assume little endian 
    //Serial.print(movement);
    /*
    if(c = 5){
     Serial.print("triggered ");
    }
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


