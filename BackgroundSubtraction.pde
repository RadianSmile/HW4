

import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioPlayer a ; 

import gab.opencv.*;
import processing.video.*;



Capture video;
OpenCV opencv;

float currentVolume ; 
float previousVolume ; 

int[] array = new int[30] ;  

void setup() {
  size(720, 480);
  //fullScreen();
  
  video = new Capture(this, 640,480);
  opencv = new OpenCV(this, 640, 480);

  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  video.start();
  
  minim = new Minim(this);
  a = minim.loadFile("a.mp3", 1024);
  a.loop();
  
}

//PImage previousImage = new PImage(5,5) ;
//PImage currentImage ;
//PImage grayDiff ; 
void draw() {
    //scale(2);
  background(0);
  //image(video, 0, 0); 
  
  //println(video);
  
  //previousImage = currentImage ;
  //currentImage = video ;
   
   
  opencv.loadImage(video);
  //opencv.diff(currentImage);
  
  //grayDiff = opencv.getSnapshot();
  //image(grayDiff,0,0) ; 
  //grayDiff.loadPixels();
  
  
  //pixelLength = grayDiff.width * grayDiff.height ; 
  
  //for (int i = 0 ; i < pixelLength ; i++) {
  //  color c = grayDiff.pixels[i] ;
  //  diffGrade = red (c) + green (c) + blue (c) ;
  //  if (diffGrade > 255*3/2) {
      
  //  }  
  //}
  
  
  
  opencv.updateBackground();
  
  opencv.dilate();
  opencv.erode();

  noFill();
  stroke(255, 0, 0);
  strokeWeight(3);
  
  //println(opencv.findContours());
  int i = 0 ;
  for (Contour contour : opencv.findContours()) {
   //contour.draw();
   ArrayList<PVector> points = contour.getPoints() ; 
   //for(int j = 0 ; j < contour.getPoints().size() ; j++ ){
     
     if (points.size()> 0){
       PVector p = points.get(0) ;
       //println(p.x , p.y) ; 
       noStroke();
       fill(random(0,255),random(0,255),random(0,255)) ; 
       ellipse(p.x , p.y , 20, 20 ) ; 
     }
   i++ ; 
  }
  
  array[frameCount % 30] = i ;
  
  if ( frameCount % 30 ==0 && a.hasControl(Controller.GAIN) )
  { //<>//
    previousVolume = currentVolume ;  
    currentVolume = map( max(array) , 20 ,250, -8, 6); //<>//
    println (max(array)) ; 
   
  } //<>//
  //println((millis() % 1000 ) /1000.0);
  float val =  previousVolume + (frameCount % 30.0 ) /30.0 * (currentVolume - previousVolume) ; //<>//
  //print(val + " ") ;
  a.setGain(val) ;
  
  //println (i) ; 
}

//void movieEvent(Movie m) {
//  m.read();
//}



void captureEvent(Capture c) {
  c.read();
  //c.read();
}