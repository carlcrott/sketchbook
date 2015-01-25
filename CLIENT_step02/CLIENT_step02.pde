#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper(stepsPerRevolution, 22,23,24,25);   
#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x30, 0x93 };
byte ip[] = { 192, 168, 2, 145 };
byte server[] = { 192,168,2,7 };
byte mybuffer[50];

byte arg[6];
char name;

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
  if (client.available() >= 6 ) { // movement command has stepperID int sign and a value

    // protocol is "CCaaaa", two bytes of command, four bytes of args
    arg[0] = client.read();
    arg[1] = client.read();
    arg[2] = client.read();
    arg[3] = client.read();
    arg[4] = client.read();
    arg[5] = client.read();
    
    // multibyte read ... but then have to step through the buffer to print it
    for(int foo = 0; foo < 6; foo++){
      Serial.print(arg[foo]);
      //Serial.print(mybuffer[foo]);
    }


    // protocol is "CCaaaa", two bytes of command, four bytes of args



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


