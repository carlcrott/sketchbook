while ( r < 300 ) {
  delayMicroseconds();
  myStepper.setSpeed(r);
  r++;
}
