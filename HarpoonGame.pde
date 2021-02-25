float worldX=0, worldY=0;
int seaLevel = 700;
int captureChance = 1;
float boatX, boatY, rs=0.5;
Harpoon[] harpoons = new Harpoon[15];
int hi=0;
int alpha;
boolean chosen = false;
boolean scrollBack, success, failure, lookAtWhale;
Whale w = new Whale(1300, 0);
int[] whaleStartx = {0, 1300, 1500, 2000, 2000, 2500, 2300, 2700, 1800, 2200, 2500};
int waveX = 260/2, waveY = seaLevel+75;
int fails, maxHarpoons;
float otheta, ots=1;
String[] wrongWhale = {"That's not a Sperm whale!\nThat's a Right whale worth $0!", "That's the wrong whale!\nIt's a Right whale worth $0!",
                        "That's a Right whale worth 0$!\nIt's alright, you'll get the right whale next time!", "That's not the White Whale!\nThat's a Right whale worth $0"};
String[] correctWhale = {"You caught a Sperm whale worth $", "You caught the right whale,\nnot the Right whale, worth $", 
                          "That's the right whale,\nnot the White Whale, worth $"};
String[] sEscaped = {"Oh no! The Sperm whale escaped!", "Oh no! The right whale left!", "You let the right whale go right! That's wrong!"};
String[] rEscaped = {"Oh no! The Right whale escaped!", "Oh no! The Right whale left!", "You let the Right whale go right! That's wrong!"};
String[] wEscaped = {"Oh no! Moby-Dick escaped!"};
int wwi, cwi, sei, rei, wei;
Cloud c1, c2, c3, c4;


void harpoonGame(int lvl){
  textSize(10);
  background(#99aaff);
  strokeWeight(2);
  stroke(#ff0000);
  fill(#ff0000);
  //background waves
  for(int i=0; i<11; i++){
    image(waves, waveX+waves.width*i, waveY-(waves.height-20));
  }
  //sun
  noStroke();
  fill(255, 230, 0);
  ellipse(200, 200, 100, 100);
  for(int i=0; i<5; i++){
    fill(255, 255, 0, 5+i*15);
    ellipse(200, 200, 100+20*i, 100+20*i);
  }
  //clouds
  c1.display();
  c2.display();
  c3.display();
  c4.display();
  
  pushMatrix();
  translate(worldX, worldY);
  //choose first available harpoon
  while(hi<harpoons.length && !chosen && !success && !failure){
    if(!harpoons[hi].landed && !harpoons[hi].launched){
      harpoons[hi].x = 300;
      harpoons[hi].y = boatY-75;
      harpoons[hi].rs = rs;
      harpoons[hi].active = true;
      chosen = true;
    } else {
      hi++;
    }
  }
  //harpooner
  pushMatrix();
  if(harpooner.p != 5){ translate(boatX+125, boatY-25);}
  else { translate(boatX+125, 650);}
  if(!harpoons[hi].launched){
    rotate(harpoons[hi].theta);
  } else {
    rotate(0);
  }
  stroke(0);
  strokeWeight(5);
  line(0, -65, 0, 0);
  line(0, -25, 25, -50);
  strokeWeight(1);
  if((lvl-1)%3 == 0 && lvl > 1 && success && harpooner.p == 4){
    image(scaredFace, 0, -65, 50, 50);
  } else {
    image(heads[harpooner.p-3], 0, -65);
  }
  popMatrix();
  //extra leg extension (for Daggoo)
  if(harpooner.p == 5){
    strokeWeight(5);
    line(boatX+125, 650, boatX+125, boatY);
    strokeWeight(1);
  }
  //display harpoons
  displayHarpoons();
  //boat
  fill(#654321);
  stroke(0);
  rect(boatX, boatY, 300, 50);
  //rowers
  rower(boatX, boatY);
  rower(boatX-100, boatY);
  if(boatY >= 695 || boatY <= 655){
    rs = -rs;
  }
  boatY += rs;
  //whale
  w.display();
  //harpoon counter
  if(!w.fast){
    for(int i=0; i<maxHarpoons-fails; i++){
      stroke(0);
      strokeWeight(2);
      line(30+i*50, 45, 55+i*50, 20);
      line(55+i*50, 20, 55+i*50, 30);
      line(55+i*50, 20, 45+i*50, 20);
    }
  }
  //ruler for TAS testing
  if(quickLoad){
    stroke(255, 0, 0);
    line(0, seaLevel, 5000, seaLevel);
    for(int i=0; i<5000; i+=100){
      line(i, seaLevel, i, seaLevel-50);
      fill(255, 0, 0);
      text(i, i, seaLevel-75);
    }
  }
  popMatrix();
  //foreground waves (11 images enough to cover width of screen twice)
  for(int i=0; i<11; i++){
    image(waves, waveX+waves.width*i, waveY);
  }
  //scroll waves left
  waveX -= 5;
  //if original wave one screen width away, reset position
  if(waveX <= 130-1300){
    waveX = 130;
  }
  //peleg tutorial
  if(lvl == 1){
    if(prompt <= 9){
      fill(0, 80);
      stroke(0, 80);
      rect(width/2, height/2, width, height);
      fill(255);
      stroke(0);
      rect(width/2, 150, 600, 220);
      textSize(25);
      fill(0);
      text(tutorialPrompts[prompt], width/2, 140);
      textSize(15);
      text("(Click to continue)", width/2, 220);
      image(peleg, pelegx, pelegy, 400, 400);
    }
  }
  //scroll button
  stroke(0);
  strokeWeight(1);
  fill(150);
  rect(width-50, height-50, 50, 50);
  strokeWeight(3);
  if(worldX == 0){
    line(width-65, height-65, width-35, height-50);
    line(width-65, height-35, width-35, height-50);
  } else {
    line(width-35, height-65, width-65, height-50);
    line(width-35, height-35, width-65, height-50);
  }
  //--------- End Graphics -------
  if(w.x-200 <= boatX+100 && w.t == 2){
    success = true;
  }
  //if harpoon within whale and not already ended
  if((harpoons[hi].x+25 >= w.targetX-80 && harpoons[hi].x+25 <= w.targetX+80 && harpoons[hi].y >= w.targetY-30 && harpoons[hi].y <= w.targetY+30 && w.t != 2
  || harpoons[hi].x+25 >= w.targetX-110 && harpoons[hi].x+25 <= w.targetX+50 && harpoons[hi].y >= w.targetY-30 && harpoons[hi].y <= w.targetY+30 && w.t == 2
  || harpooner.p == 3 && harpoons[hi].x+25 >= w.targetX+225 && harpoons[hi].x+25 <= w.targetX+275 && harpoons[hi].y >= w.targetY-50 && harpoons[hi].y <= w.targetY+50 && w.t != 2
  || harpooner.p == 3 && harpoons[hi].x+25 >= w.targetX+150 && harpoons[hi].x+25 <= w.targetX+200 && harpoons[hi].y >= w.targetY-50 && harpoons[hi].y <= w.targetY+50 && w.t == 2)
  && !success && !failure){
    float mult=1;
    if(harpooner.p == 4){
      if(w.t == 2){ 
        mult += 0.25;
        if(harpooner.synergy){ mult += 0.25;}
      } else {
        mult += 0.1;
        if(harpooner.synergy){ mult += 0.1;}
      }
    }
    if(w.fast){
      //determine whether whale has been captured
      if(w.t == 2){
        captureChance += 11-chapter;
      } else {
        captureChance += 33;
        if(harpooner.p == 3){
          captureChance += 15;
          if(harpooner.synergy){ captureChance += 15;}
        }
      }
      int r = (int)random(0, 100);
      if(r < captureChance){
        if(w.t != 2 && !success){
          success = true;
          cwi = (int)random(0, correctWhale.length);
          wwi = (int)random(0, wrongWhale.length);
        } else {
          w.moveToPosition(boatX+100, 15);
        }
        w.dead = true;
      } else {
        //move whale
        w.moveToPosition(w.x-100*mult);
      }
    } else {
      //move whale
      w.moveToPosition(w.x-300*mult);
    }
    //set harpoon "anchor position" inside of whale
    harpoons[hi].setLanded();
    harpoons[hi].offset = w.x-harpoons[hi].x;
    harpoons[hi].fast = true;
    harpoons[hi].rs = w.rs;
    harpoons[hi].wy = w.y;
    harpoons[hi].newy = harpoons[hi].y;
    scrollBack = true;
    w.fast = true;
    //prepare next harpoon
    chosen = false;
    hi = 0;
  } else if (harpoons[hi].y > 700 && harpoons[hi].launched) {
    //if miss, reset
    harpoons[hi].reset();
    scrollBack = true;
    if(w.fast){
      //move whale if already hit
      w.moveToPosition(w.x+200);
    } else {
      fails ++;
    }
  }
  //fail if whale moves too far away or out of harpoons
  if((w.x >= whaleStartx[lvl]+200 || fails >= maxHarpoons) && !failure){
    failure = true;
    rei = (int)random(0, rEscaped.length);
    sei = (int)random(0, sEscaped.length);
    wei = (int)random(0, wEscaped.length);
  }
  if(success){
    fill(0, alpha);
    rect(width/2, height/2, width, height);
    textSize(50);
    fill(255);
    if(murdInt){
      text("Murderous Intent!", width/2, 300);
    }
    if(w.t == 1){
      text(correctWhale[cwi]+w.worth+"!", width/2, height/2);
    } else if(w.t == 0){
      text(wrongWhale[wwi], width/2, height/2);
    } else if(w.t == 2){
      text("Oh no! Moby-Dick stove your boat!", width/2, height/2);
    }
    textSize(15);
    text("(Click to continue)", width/2, height-100);
    //fade in
    alpha += 5;
    if(alpha >= 255 && mousePressed && mouseReleased){
      if(lookout.p == 1){
        if(lookout.synergy){
          w.worth *= 1.2;
        } else {
          w.worth *= 1.1;
        }
      }
      if(w.t == 1){
        money += w.worth;
      }
      levelCleared[lvl] = true;
      transitioning = true;
      if((level-1)%3 == 0 && level != 1){
        if(chapter != 4){
          chapter ++;
          transitionTo = 2;
          transitionType = 2;
          shipPositioned = false;
        } else {
          transitionTo = 5;
          transitionType = 0;
        }
      } else { 
        transitionType = 1;
        transitionTo = 2;
      }
      alpha = 0;
      pelegy = height-200;
      }
  } else if(failure){
    fill(0, alpha);
    rect(width/2, height/2, width, height);
    resetHarpoons();
    fill(255);
    textSize(50);
    if(w.t == 0){
      text(rEscaped[rei], width/2, height/2);
    } else if(w.t == 1){
      text(sEscaped[sei], width/2, height/2);
    } else if(w.t == 2){
      text(wEscaped[wei], width/2, height/2);
    }
    textSize(15);
    text("(Click to continue)", width/2, height-100);
    //fade in
    alpha += 5;
    if(alpha >= 255 && mousePressed && mouseReleased){
      level --;
      transitioning = true;
      transitionTo = 2;
      alpha = 0;
      pelegy = height-200;
      lookout.used = false;
      for(int i=0; i <spouts.length; i++){
        spouts[i].wrong = false;
      }
    }
  }
  //scroll world back to boat
  if(scrollBack){
    worldX += 20;
    if(worldX >= 0){
      worldX = 0;
      scrollBack = false;
    }
  }
  if(lookAtWhale){
    if(worldX > -w.x+width/2){
      worldX -= 20;
    }
    if(worldX <= -w.x+width/2){
      worldX = -w.x+width/2;
      lookAtWhale = false;
    }
  }
}
void resetHarpoons(){
  for(int i=0; i<harpoons.length; i++){
    harpoons[i].reset();
  }
  hi = 0;
  chosen = false;
}
void displayHarpoons(){
  for(int i=0; i<harpoons.length; i++){
    harpoons[i].display();
    harpoons[i].whaleX = w.x;
  }
}
void rower(float x, float y){
  //oar
  pushMatrix();
    translate(x, y);
    rotate(radians(otheta));
    fill(#caa472);
    stroke(0);
    strokeWeight(1);
    rect(0, 10-map(-otheta, -45, 45, 0, 25), 5, 100-2*map(-otheta, -45, 45, 0, 25));
    rect(0, -40, 10, 5, 3);
    ellipse(0, 60-map(-otheta, -45, 45, 0, 25), 20, 40);
    otheta += ots;
    if(otheta >= 45){ ots = -1.5;}
    else if(otheta <= -45){ ots = 2;}
  popMatrix();
  //head, body
  fill(20);
  rect(x-20, y-50, 5, 50);
  fill(0);
  ellipse(x-20, y-80, 40, 40);
  strokeWeight(3);
  //arms, map functions follow rotation
  stroke(0);
  line(x-20, y-50, x+map(otheta, -45, 45, -30, 30)-25, y-35);
  line(x+map(otheta, -45, 45, -30, 30)-25, y-35, x+map(otheta, -45, 45, -30, 30), y-35+map(abs(otheta), 0, 45, 0, 10));
  //arm 2
  stroke(50);
  line(x-20, y-50, x-map(otheta, -45, 45, -10, 10)-25, y);
  line(x-map(otheta, -45, 45, -10, 10)-25, y, x-map(otheta, -45, 45, -10, 10), y+10-map(abs(otheta), 0, 45, 0, 5));
  strokeWeight(1);
}
class Cloud{
  int x;
  int y;
  Cloud(int tx, int ty){
    x = tx;
    y = ty;
  }
  void display(){
    fill(255);
    noStroke();
    ellipse(x, y-20, 50, 40);
    ellipse(x, y+20, 50, 40);
    ellipse(x+30, y-10, 40, 40);
    ellipse(x+30, y+10, 40, 40);
    ellipse(x-30, y-10, 40, 40);
    ellipse(x-30, y+10, 40, 40);
    ellipse(x, y, 50, 30);
    x --;
    if(x < -50){
      x = width+50;
    }
  }
}
