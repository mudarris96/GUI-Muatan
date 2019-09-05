void ins(){
  Wire.begin();
  accelgyro.initialize();
  accelgyro.setI2CBypassEnabled(true); // set bypass mode
  if (!bmp.begin()) {}

  mag.initialize();
  serial_gps.begin(9600);
   
  
  Wire.beginTransmission(hmc5883Address);  //Begin communication with compass
  Wire.write(hmc5883ModeRegister);  //select the mode register
  Wire.write(hmcContinuousMode); //continuous measurement mode
  Wire.endTransmission();
  }
