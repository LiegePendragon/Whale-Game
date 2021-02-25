PImage whaleSilhouette;
PImage rWhaleSilhouette;
PImage rwsc;
int a, as;
float theta = -39;
Star[] stars = new Star[500];
Star shootingStar = new Star(0, 0, 1);

class Star{
  
  int x, y;
  int a, as;
  int t;
  float s;
  Star(int tx, int ty, int type){
    x = tx;
    y = ty;
    a = (int)random(100, 200);
    as = 10;
    t = type;
    s = 3;
    if(t == 1){
      x = (int)random(0, width/2);
      y = (int)random(0, 0);
      s = 5;
      a = 199;
      as = 0;
    }
  }
  void display(){
    fill(255, 255, 255, a);
    ellipse(x, y, s, s);
    if(a >= 200){ as = -6;}
    else if(a <= 100){ as = 6;}
    a += as;
    if(t == 1){
      for(int i=1; i<=20; i++){
        ellipse(x-2*i, y-i, s-i*3/20, s-i*3/20);
      }
      x += 6;
      y += 3;
      if(y >= height/2+100){
        y = (int)random(-500, 0);
        x = (int)random(0, width/2);
      }
    }
  }
}



void titleScreen(){
  background(#020240);
  for(int i=0; i<stars.length; i++){
    stars[i].display();
  }
  shootingStar.display();
  noStroke();
  //horizon gradient
  for(int i=0; i<100; i++){
    fill(244, 135, 75, 255-i*2.55);
    rect(width/2, height/2+50-i*2, width, 2);
  }
  //sun corona gradient
  for(int i=0; i<30; i++){
    fill(255, 150-i, 0, 20-i*20/30);
    ellipse(width/2, height/2-25, 150+i, 150+i);
  }
  //sun
  fill(255, 150, 0);
  ellipse(width/2, height/2-25, 150, 150);
  //whale
  pushMatrix();
  translate(width/2, height/2+60);
  rotate(radians(-theta));
  image(whaleSilhouette, 0, -50, 100, 50);
  popMatrix();
  //water
  fill(#101050);
  rect(width/2, height/2+250, width, 400);
  //sun reflection gradient
  for(int i=0; i<100; i++){
    fill(255, 50+i, 0, 150);
    rect(width/2, height/2+53+i*4, 30+i*2, 5);
  }
  //whale reflection
  pushMatrix();
  translate(width/2, height/2+40);
  rotate(radians(theta));
  scale(1, -1);
  image(rWhaleSilhouette, 0, -50, 100, 50);
  popMatrix();
  //water shading (ish)
  for(int i=0; i<100; i++){
    fill(255, 255, 255, 60);
    rect(width/2, height/2+55+i*10, width, 5);
  }
  //-39 to -116 down
  //-242 to -312 up
  //load pixel arrays of images
  rWhaleSilhouette.loadPixels();
  rwsc.loadPixels();
  int w=0;
  if(theta%-360 < -20 && theta%-360 > -120){
    //if the whale should be disappearing, width being taken away = angle rotated (-30 to -116) mapped to actual image width (30 to width-50)
    w = (int)map(theta%-360, -30, -116, 30, rWhaleSilhouette.width-50);
  } else if(theta%-360 < -230 && theta%-360 > -320){
    //if the whale should be reappearing, width being restored = angle rotated (-242 to -312) mapped to actual image width (30 to width-50)
    w = (int)map(theta%-360, -242, -312, 30, rWhaleSilhouette.width-50);
  }
  if(theta%-360 < -20 && theta%-360 > -120){
    //for each pixel until desired width is reached
    for(int j=w; j>=0; j--){
      //for the height of each pixel controlled by "w"
      for(int i=1; i<rWhaleSilhouette.height; i++){
        //check if index would be out of bounds
        if(rWhaleSilhouette.width*i-j > 0){
          //make the portion of image denoted by "w" transparent
          rWhaleSilhouette.pixels[rWhaleSilhouette.width*i-j] = color(255, 0, 0, 0);
        }
      }
    }
  } else {
    //same as above, just reverse
    for(int j=w; j>=0; j--){
      for(int i=1; i<rWhaleSilhouette.height; i++){
        if(rWhaleSilhouette.width*i-j > 0){
          //restore portion of image denoted by "w" with a backup copy
          rWhaleSilhouette.pixels[rWhaleSilhouette.width*i-j] = rwsc.pixels[rWhaleSilhouette.width*i-j];
        }
      }
    }
  }
  //update the image
  rWhaleSilhouette.updatePixels();
  //rotation stuff, slow down when under water
  if(theta%-360 < -120 && theta%-360 > -240){theta -= 0.5;}
  else {theta -= 3;}
  
  fill(255);
  textSize(100);
  text("MOBY-DICK:", width/2, 75);
  textSize(50);
  text("A Whaling Adventure", width/2, 200);
  fill(255, 255, 255, 150+a);
  textSize(20);
  text("Click anywhere to begin", width/2, height-200);
  if(a >= 105){ as = -3;}
  else if(a <= 0){ as = 3;}
  a += as;
  if(mousePressed){
    transitioning = true;
    transitionTo = 1;
    transitionType = 0;
  }
}

void endScreen(){
  background(0);
  fill(230);
  textFont(IshmaelWriting);
  textSize(100);
  text("Finis", width/2, 300);
  textFont(normal);
  textSize(60);
  text("Thank you for playing!", width/2, 600);
  //exit automatically after 20 seconds
  if(millis()-timer > 20000){
    exit();
  }
}
