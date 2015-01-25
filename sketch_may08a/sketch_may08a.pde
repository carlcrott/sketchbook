
int DIR = 3;
int STEP = 2;
int MS1 = 22;
int MS2 = 9;
int SLEEP = 23;


void setup() {
  Serial.begin(9600);
  pinMode(DIR, OUTPUT);
  pinMode(STEP, OUTPUT);
  pinMode(MS1, OUTPUT);
  pinMode(MS2, OUTPUT);
  pinMode(SLEEP, OUTPUT);
}



void loop()
{
  int modeType = 1;
  while (modeType <= 8){
    digitalWrite(DIR, LOW);
    digitalWrite(MS1, MS1_MODE(modeType));
    digitalWrite(MS2, MS2_MODE(modeType));
    digitalWrite(SLEEP, HIGH);

    int i = 0;
    while(i < (modeType * 200))
    {
      digitalWrite(STEP, LOW);
      digitalWrite(STEP, HIGH);
      delayMicroseconds(1600/modeType);

      i++;                      
    }                              
    modeType = modeType * 2;

    delay(500);
  }
  digitalWrite(SLEEP, LOW);
  Serial.print("SLEEPING..");
  delay(1000);
  Serial.print("z");
  delay(1000);
  Serial.print("z");
  delay(1000);
  Serial.print("z");
  delay(1000);
  Serial.println("");
  digitalWrite(SLEEP, HIGH);
  Serial.println("AWAKE!!!");
  delay(1000);
}



int MS1_MODE(int MS1_StepMode){
  switch(MS1_StepMode){
  case 1:
    MS1_StepMode = 0;
    Serial.println("Step Mode is Full...");
    break;
  case 2:
    MS1_StepMode = 1;
    Serial.println("Step Mode is Half...");
    break;
  case 4:
    MS1_StepMode = 0;
    Serial.println("Step Mode is Quarter...");
    break;
  case 8:
    MS1_StepMode = 1;
    Serial.println("Step Mode is Eighth...");
    break;
  }
  return MS1_StepMode;
}



int MS2_MODE(int MS2_StepMode){
  switch(MS2_StepMode){
  case 1:
    MS2_StepMode = 0;
    break;
  case 2:
    MS2_StepMode = 0;
    break;
  case 4:
    MS2_StepMode = 1;
    break;
  case 8:
    MS2_StepMode = 1;
    break;
  }
  return MS2_StepMode;
}
