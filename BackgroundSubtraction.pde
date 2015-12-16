import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;



void setup() {
  size(720, 480);
  video = new Capture(this, 720,480);
  opencv = new OpenCV(this, 720, 480);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  video.start();
  
}

//PImage previousImage = new PImage(5,5) ;
//PImage currentImage ;
//PImage grayDiff ; 
void draw() {
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
       println(p.x , p.y) ; 
       noStroke();
       fill(random(0,255),random(0,255),random(0,255)) ; 
       ellipse(p.x , p.y , 20, 20 ) ; 
     }
     
     
   //}
   i++ ; 
  }
  println (i) ; 
}

//void movieEvent(Movie m) {
//  m.read();
//}

void captureEvent(Capture c) {
  c.read();
  //c.read();
}