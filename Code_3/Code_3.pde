#include <Firmata.h>


// PHOTO-RESISTOR (H -6,7)
  int lightPin = 0; //the analog pin the photoresistor is connected to to

// LED LIGHT (H- 22,23)
  int ledPin = 8;   //the pin the LED is connected to

// SERVO CONTROLLED BY PHOTO-RESISTOR (H- 14,15)
   #include <Servo.h> 
  
  Servo servo1; 
  int potpin = 1;  // analog pin used to connect the photo-resistor
  int val;    // variable to read the value from the analog pin 


                  
void setup()
{
 
    Firmata.setFirmwareVersion(0, 1);
   Firmata.begin(57600);
  
// LED LIGHT
  pinMode(ledPin, OUTPUT); //sets the led pin to output
  
// SERVO1
   Serial.begin(9600);
   servo1.attach(9);  // attaches the servo on pin 9 to the servo object 
   
}

 
 
void loop()
{

// LED LIGHT
  int lightLevel = analogRead(lightPin); // Read the lightlevel
  lightLevel = map(lightLevel, 0, 900, 0, 255); // adjust the value 0 to 900 to span 0 to 255
  lightLevel = constrain(lightLevel, 0, 255);//make sure the value is betwween 0 and 255
  analogWrite(ledPin, lightLevel);  //write the value

  
// SERVO1
  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
 Firmata.sendAnalog(potpin,val); 
  val = map(val, 0, 1023, 0, 170);     // scale it to use it with the servo (value between 0 and 180) 
  servo1.write(val);                  // sets the servo position according to the scaled value 
  delay(15);        
  
    
  
}
