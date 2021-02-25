class Spout{
  int x, y, t, ai;
  int pos;
  PImage[] animation;
  boolean wrong;
  Spout(int tx, int ty, int type){
    x = tx;
    y = ty;
    t = type;
    ai = 0;
    pos = 100;
  }
  void display(){
    if(t != 0 && pos < 10){
      x = 400+(2-(pos%3))*200;
      y = 200+(pos/3)*200;
    }
    if(t==2){
      if(frameCount%48 < 24){
        image(goodSpout[frameCount%24], x+10, y-25, 200, 200);
      } else {
        image(goodSpout[0], x+10, y-25, 200, 200);
      }
    } else if(t==1){
      if(frameCount%48 < 24){
        image(badSpout[frameCount%24], x+10, y-25, 200, 200);
      } else {
        image(badSpout[0], x+10, y-25, 200, 200);
      }
    } else if(t==0){
      image(badSpout[frameCount%24], x, y-25, 100, 100);
    }
    if(revealHitboxes){
      if(t==0){stroke(0, 0, 255);}
      else if(t==1){stroke(255, 0, 0);}
      else if(t==2){stroke(0, 255, 0);}
      noFill();
      strokeWeight(1);
      rect(x, y, 100, 100);
    }
    if(wrong){
      stroke(200, 0, 0);
      strokeWeight(3);
      line(x-25, y-25, x+25, y+25);
      line(x+25, y-25, x-25, y+25);
      strokeWeight(1);
    }
  }
  boolean clicked(){
    if(mousePressed && mouseReleased){
      if(mouseX <= x+50 && mouseX >= x-50 && mouseY <= y+50 && mouseY >= y-50){
        return true;
      }
    }
    return false;
  }
}
