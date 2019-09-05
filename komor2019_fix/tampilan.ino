void tampilan(){
  
 Serial.print("0DH");
 Serial.print("\t");

 Serial.print("00");
 Serial.print("\t");
 Serial.print("02");
 Serial.print("\t");
 Serial.print("01");
 Serial.print("\t");
 Serial.print(latitude); Serial.print("\t"); 
 Serial.print(longitude); Serial.print("\t"); 

//data accelero gyro gy-521
  accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  Serial.print(ax); Serial.print("\t");
  Serial.print(ay); Serial.print("\t");
  Serial.print(az); Serial.print("\t");
  Serial.print(gx); Serial.print("\t");
  Serial.print(gy); Serial.print("\t");
  Serial.print(gz); Serial.print("\t");

  // request temperature
    Serial.print(bmp.readTemperature());Serial.print("\t");
    Serial.print(bmp.readPressure());Serial.print("\t");
    Serial.print(bmp.readAltitude(101500));Serial.print("\t");

// kompas
    Wire.beginTransmission(hmc5883Address);
    Wire.write(hmcDataOutputXMSBAddress);  //Select register 3, X MSB register
    Wire.endTransmission();
  
    //Read data from each axis of the Digital Compass
    Wire.requestFrom(hmc5883Address,6);
    if(6<=Wire.available())
    {
      x = Wire.read()<<8; //X msb
      x |= Wire.read();   //X lsb
      z = Wire.read()<<8; //Z msb
      z |= Wire.read();   //Z lsb
      y = Wire.read()<<8; //Y msb
      y |= Wire.read();   //Y lsb    
    }  
    int angle = atan2(-y,x)/M_PI*180;
    if (angle < 0){angle = angle + 360;}
    Serial.print(angle); Serial.println("\t");
  }
