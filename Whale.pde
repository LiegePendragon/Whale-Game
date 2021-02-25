class Whale{
  float x, y, t, targetX, targetY, rs = 0.3;
  int w, h;
  boolean move, fast, dead;
  float dest, dir;
  int worth, speed;
  
  Whale(int x, int type){
    this.x = x;
    y = seaLevel-30;
    t = type;
    w = 400;
    h = 200;
    targetY = y;
    worth = (int)random(1000, 100000);
    speed = 10;
  }
  void display(){
    if(t==2){targetX = x-w/8;}
    else{targetX = x-w/4;}
    if(t == 2){
      image(whiteWhale, x, y, w, h);
    } else {
      image(whale, x, y, w, h);
    }
    if(revealHitboxes){
      strokeWeight(1);
      stroke(255, 0, 0);
      noFill();
      //hitboxes
      if(t != 2){
        rect(targetX, targetY, 190, 60);
      } else {
        rect(targetX-30, targetY, 190, 60);
      }
      if(harpooner.p == 3){
        if(t == 2){
          rect(targetX+175, targetY, 50, 100);
        } else {
          rect(targetX+250, targetY, 50, 100);
        }
      }
    }
    if(y >= seaLevel-20 || y <= seaLevel-40){
      rs = -rs;
    }
    y += rs;
    targetY += rs;
    if(move){
      x += speed*dir;
      if(dir==1 && dest <= x || dir==-1 && dest >= x){ 
        x = dest;
        move = false;
      }
    }
  }
  void moveToPosition(float d){
    speed = 10;
    move = true;
    dest = d;
    if(d > x){ dir = 1;}
    else if(d < x){ dir = -1;}
  }
  void moveToPosition(float d, int s){
    speed = s;
    move = true;
    dest = d;
    if(d > x){ dir = 1;}
    else if(d < x){ dir = -1;}
  }
  
}
