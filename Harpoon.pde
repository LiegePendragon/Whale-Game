class Harpoon {
  float x, y, ogx, ogy, wy, newy;
  float theta;
  boolean launched, landed, active, fast;
  float dx, dy;
  float power, ypower, xpower, maxPower;
  float offset, whaleX;
  float rs = 0.5;
  Harpoon(float x, float y, float p) {
    this.x = x;
    this.y = y;
    ogx = x;
    ogy = y;
    maxPower = p;
  }
  void display() {
    if (!launched && !landed) {
      dx = mouseX - x;
      dy = y - mouseY;
      if (dy < 0) { 
        dy = 1;
      }
      if (dy > 400) { 
        dy = 400;
      }
      if (dx < 0) { 
        dx = 1;
      }
      if (dx > 400) { 
        dx = 400;
      }
      theta = atan2(-dy, dx);
    } else if (!landed) { 
      theta = atan2(-ypower, xpower);
    }
    pushMatrix();
    if(!launched && !landed && active){
      if(harpooner.p != 5){ translate(boatX+125, boatY-25);}
      else { translate(boatX+125, 650);}
      x = 300-map(theta, -HALF_PI, 0, 75, 0);
    } else {
      translate(x, y);
    }
    rotate(theta);
    //guiding line
    if (!launched && !landed && active) {
      for (int i=0; i<10; i++) {
        noStroke();
        fill(#ff0000);
        float d = dist(mouseX, mouseY, x+50-50*cos(theta), y+50*sin(theta));
        if (d > 200) { 
          d = 200;
        }
        ellipse(75+i*map(d, 0, 200, 0, 20), -50, 5, 5);
      }
    }
    if(!launched && !landed && active){
      //spear
      stroke(0);
      strokeWeight(2);
      line(-25, -50, 75, -50);
      line(75, -50, 65, -40);
      line(75, -50, 65, -60);
    } else {
      //spear
      stroke(0);
      strokeWeight(2);
      line(-50, 0, 50, 0);
      line(50, 0, 40, 10);
      line(50, 0, 40, -10);
    }
    popMatrix();
    if(revealHitboxes){
      //hitbox used for contact with whale
      noFill();
      stroke(255, 0, 0);
      strokeWeight(1);
      rect(x+25*cos(theta), y+25*sin(theta), 5, 5);
    }
    if(!launched && !landed && active && harpooner.p != 5){
      if(y >= 620 || y <= 580){
        rs = -rs;
      }
      y += rs;
    }
    if(fast){
      //match whale vertical movement when attached
      stroke(0);
      line(x, y, boatX+150, boatY-24);
      x = whaleX - offset;
      float diff, ubound, lbound;
      if(rs > 0){ 
        diff = 10-(wy-(seaLevel-30));
        ubound = newy+diff; //larger number, lower stop
        lbound = newy-(20-diff); //smaller number, upper stop
      }
      else { 
        diff = 10-((seaLevel-30)-wy);
        ubound = newy+(20-diff); //larger number, lower stop
        lbound = newy-diff; //smaller number, upper stop
      }
      if(y >= ubound || y <= lbound){
        rs = -rs;
      }
      y += rs;
    }
    if (launched) {
      //move harpoon based on power when tossed
      y -= ypower;
      x += xpower;
      //move world when harpoon is in the middle of the screen
      if (x >= width/2) { 
        worldX -= xpower;
      }
      ypower -= 0.1;
    }
    if(landed){
    xpower = 0;
    ypower = 0;
  }
  }
  void setLanded(){
    landed = true;
    launched = false;
    chosen = false;
  }
  void toss() {
    //max power is 10 by default
    power = 10;
    if(harpooner.p == 5){ 
      //max power is 12 if Daggoo
      power += 2;
      //max power is 14 if synergy with Daggoo
      if(harpooner.synergy){ power += 2;}
    }
    //cap power at 5/3 max power (if cursor is over 500 px away)
    if(dx > 500){ dx = 500;}
    if(dy > 500){ dy = 500;}
    //map power based on cursor position and max power
    ypower = power*map(dy, 0, 300, 0, 1);
    xpower = power*map(dx, 0, 300, 0, 1);
    //if using TAS, set power automatically
    if(TAS){
      //calcs and powers for not Daggoo
      if(harpooner.p != 5){
        //(MAX, MAX) = 3800 landed, whale 3800
        //(MAX, 5) = 2200 landed, whale 2200
        //(MAX, 3) = 1700 landed, whale 1600
        //(MAX, 1.5) hits whale 1300
        //ypower = 1.5;
        ypower = power*map(w.x, 1300, 3800, 0.15, 1);
        if(w.x > 900){
          xpower = power*map(500, 0, 300, 0, 1);
        } else {
          xpower = power*map(400, 0, 300, 0, 1);
        }
      } else {
        if(harpooner.synergy){
          //(MAX, 8) = 4200
          //(MAX, 0) = hits whale 1300
          ypower = power*map(w.x, 1300, 4100, 0, (8f/14f));
          xpower = power*map(500, 0, 300, 0, 1);
        } else {
          //(MAX, 4) = 2300, hits whale 2000
          //(MAX, 0) = hits whale 1300
          //ypower = 4;
          ypower = power*map(w.x, 1300, 2200, (0.25/14f), (4f/14f));
          xpower = power*map(500, 0, 300, 0, 1);
        }
      }
    }
    launched = true;
  }
  void reset() {
    x = ogx;
    y = ogy;
    xpower = 0;
    ypower = 0;
    launched = false;
    landed = false;
    active = false;
    fast = false;
    chosen = false;
  }
}
