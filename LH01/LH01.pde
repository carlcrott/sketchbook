// plate Driver
int MS1 = 22;
int MS2 = 23;
int DIR = 24;
int STEP = 25;
int SLEEP = 26;


void setup() {
  Serial.begin(9600);     // open the serial connection at 9600bps
  pinMode(MS1, OUTPUT);   // set pin 22 to output
  pinMode(MS2, OUTPUT);   // set pin 23 to output
  pinMode(DIR, OUTPUT);   // set pin 24 to output
  pinMode(STEP, OUTPUT);  // set pin 25 to output
  pinMode(SLEEP, OUTPUT); // set pin 26 to output
}


// define motor plateDriver;
// define motor pumpDriver;

int liquidVolume;
int liquidVolumePerStep;
int encoderVarFront;
int encoderVarBack;

void loop(){
  step.plateDriver( -150,000 );
  
  // program waits here till  issued command from rails
  
  while( encoderVarBack = 1 ) {
       step.plateDriver( -1);
  } // see how accurate this is...does it need to be zeroed a few times?
  
  // encoder var = 0 
  // plate is zeroed -- directly above first set of wells
  
  while( wellCount <= 12) {
      liquidVolumePerStep = liquidVolume/10 // some static correlating to the #of steps to cross an entire well
      while( i=0 ; i<10 ; ++i ) {
          step.dispenser(liquidVolumePerStep);
          step.plateDriver(20);
      }
      // sufficient steps to position next well under dispensing tip
      step.plateDriver(10);
  }
  
  // dispensing loop finishes
  step.plateDriver( 150000 );
  
  while( encoderVarFront = 1){
      step.plateDriver(1);
  }
  
  // plate is full forward 
}
