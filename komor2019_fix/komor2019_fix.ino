#include <SoftwareSerial.h>
#include <TinyGPS.h>
#include <I2Cdev.h>
#include <MPU6050.h>
#include <Wire.h>
#include <Adafruit_BMP085.h>
#include <HMC5883L.h>
#include <TinyGPS++.h> 
#include <BMP180.h>

BMP180 barometer;
SoftwareSerial serial_gps(3,2);
TinyGPSPlus gps;

MPU6050 accelgyro;
Adafruit_BMP085 bmp;
HMC5883L mag;

//HMC5883L Digital Compass
const int hmc5883Address = 0x1E; //0011110b, I2C 7bit address for compass
const byte hmc5883ModeRegister = 0x02;
const byte hmcContinuousMode = 0x00;
const byte hmcDataOutputXMSBAddress = 0x03;
int x,y,z; //triple axis data from HMC5883L.

char status;
double baseline,T,P,a,latitude, longitude;
int16_t ax, ay, az,gx, gy, gz, mx, my, mz;
int32_t lastMicros;
int error = 0;
long lat, lon;
float flat, flon;
unsigned long age, date, time, chars;
int year;
byte month, day, hour, minute, second, hundredths;
unsigned short sentences, failed;
bool newdata = false;

void gpsdump(TinyGPS &gps);
void printFloat(double f, int digits = 2);
////
#include <arduino.h>
#include <SD.h>
#define PIC_PKT_LEN    128        //data length of each read, dont set this too big because ram is limited
#define PIC_FMT_VGA    7
#define PIC_FMT_CIF    5
#define PIC_FMT_OCIF   3
#define CAM_ADDR       0
#define CAM_SERIAL     softSerial

#define PIC_FMT        PIC_FMT_VGA
int Serialval = 0;

File myFile;
SoftwareSerial softSerial(4, 5);  //rx,tx (11-13 is used by sd shield)

const byte cameraAddr = (CAM_ADDR << 5);  // addr
const int buttonPin = A5;                 // the number of the pushbutton pin
unsigned long picTotalLen = 0;            // picture length
int picNameNum = 0;


void setup(){
  Serial.begin(57600);
  ins();
  }

void loop(){
  Serialval = Serial.read();   
  if (Serialval == '0') {
    while(1){CAM_SERIAL.begin(9600); initialize();break;}
    while(1){
        int n = 0;
        //delay(200);
        if (n == 0) preCapture();
        Capture();
        //Serial.print("Saving picture...");
        
       // Serial.print("siap kirim data................");
        GetData();
        Serialval = '1';
        Serial.write(13);
        delay(1000);
        break;}
  }
data_gps(); 
tampilan();
}
