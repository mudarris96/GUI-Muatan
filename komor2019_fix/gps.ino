void data_gps() {
  
  while(serial_gps.available()) {
    gps.encode(serial_gps.read());
  }
  if(gps.location.isUpdated()) {
    latitude = gps.location.lat();
    longitude = gps.location.lng();
  }  
}
