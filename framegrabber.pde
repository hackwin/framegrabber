// www.jbcse.com

import processing.serial.*;

Serial myPort;  // Create object from Serial class

int x = 0;
int y = 0;

void setup(){
  size(320, 240);
  println((Object)Serial.list());
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 460800);  
}

void draw(){
  while ( myPort.available() > 0) {  // If data is available,
    if(x == 0 && y == 0){
      waitForImageStart("*RDY*\r\n"); //wait for arduino program to become ready
    }
    set(x, y, color((byte)(myPort.read()) & 0xFF)); //convert signed byte to unsigned, set color from 0 (black) to 255 (white)
    x++;
    if(x == width){
      x = 0;
      y++;
      if (y == height){
         y = 0;         
      }       
    }
  }
}

void keyPressed(){
  if (key == 's' || key == 'S')
    saveFrame("frame-####.bmp");
}

void waitForImageStart(String s){
  for(int i=0; i<s.length(); i++){
   while(myPort.available() == 0){
     delay(100);
   }
   myPort.readStringUntil(s.charAt(i));
  }
}