PImage map; //1920x1080
PImage peleg;
PImage ship;
float pelegx, pelegy, pelegxs, pelegys;
float shipx=370, shipy=180, shipxs, shipys;
float scale=1.5;
int mapy = 460;
int pathLength = 10;
boolean[] levelCleared = new boolean[11];
int level=0;
int prompt=0;
int xoff = 920;
int yoff1=460, yoff2=100, yoff3=-150;
boolean shipPositioned;
Button toCredits;
String[] tutorialPrompts = {"Morning to thee, sailor! I'm Captain Peleg and\nthis here is your ship, the Pequod.", 
  "Now that you've shipped out from Nantucket,\nyou have your first opportunity to catch a whale.\nClick on the water spout to identify the whale.",
  "Look sharp! Find the spout that's different\nand click on it to lower for the whale.",
  "Be careful, however, for you won't know if\nyou've identified a sperm whale until after you\ncapture it.",
  "Welcome to the chase, sailor! You can view\nthe whale's positioning better by clicking the\nbutton in the bottom right.",
  "When you are ready to throw, drag your\nmouse to set the power and aim your throw.\nThe harder you throw the better!",
  "You have a limited amount of harpoons to\ninitially hit the whale, displayed above my head.\nAim for the head!",
  "If you hit the whale again, you have a\n chance to capture it or pull it closer.",
  "But if you miss, the leviathan will try\nto escape and swim away. Don't let it get too far\nor your lines will break and it will escape!",
  "Once you capture it, you can harvest its\noil for money if it's a Sperm whale, but the Right\nwhale will get you nothing. Good luck!",
  "Good job, you caught your first whale!\nI must return to Nantucket now, but catch me\nsome more whales and make us rich!"};

Spout lvlMarker = new Spout(1000, -100, 0);

Path path1 = new Path(360-xoff, 172-yoff1, 400-xoff, 266-yoff1);
Path path2 = new Path(400-xoff, 266-yoff1, 550-xoff, 376-yoff1);
Path path3 = new Path(550-xoff, 376-yoff1, 572-xoff, 472-yoff1);
Path path4 = new Path(572-xoff, 472-yoff1, 664-xoff, 568-yoff1);
Path path5 = new Path(664-xoff, 568-yoff1, 729-xoff, 362-yoff2);
Path path6 = new Path(729-xoff, 362-yoff2, 655-xoff, 520-yoff2);
Path path7 = new Path(655-xoff, 520-yoff2, 540-xoff, 632-yoff2);
Path path8 = new Path(540-xoff, 632-yoff2, 520-xoff, 545-yoff3);
Path path9 = new Path(520-xoff, 545-yoff3, 402-xoff, 691-yoff3);
Path path10 = new Path(402-xoff, 691-yoff3, 279-xoff, 647-yoff3);
Path[] paths = {path1, path2, path3, path4, path5, path6, path7, path8, path9, path10};

class Path {
  float slope;
  int sx, sy, ex, ey;
  float x, y;
  float numDots, a;
  boolean revealed, moveShip, moving, moved;

  Path(int startx, int starty, int endx, int endy) {
    sx = startx;
    sy = starty;
    ex = endx;
    ey = endy;
    numDots = (int)dist(sx, sy, ex, ey)/20;
    moving = false;
    moved = false;
  }
  void display() {
    stroke(#ff0000, a);
    strokeWeight(5);
    for (int i=0; i<numDots; i++) {
      x = lerp(sx, ex, i/numDots);
      y = lerp(sy, ey, i/numDots);
      point(x, y);
    }
    stroke(0, a);
    strokeWeight(1);
    fill(#ff0000, a);
    ellipse(ex, ey, 10, 10);
    if (revealed && a<255) {
      a += 10;
    }
    int yoff;
    if (chapter == 3) { 
      yoff = 100;
    } else if (chapter == 4) { 
      yoff = -150;
    } else { 
      yoff = 460;
    }
    if (moveShip && !moved && !transitioning) {
      if (!moving) {
        shipxs = (ex+920-shipx)/20f;
        shipys = (ey+yoff-shipy)/20f;
        moving = true;
      }
      if(shipxs > 0){
        if (shipx >= ex+920) {
          shipxs = 0;
          shipys = 0;
          shipx = ex+920;
          shipy = ey+yoff;
          moved = true;
        }
      } else if(shipxs < 0){
        if (shipx <= ex+920) {
          shipxs = 0;
          shipys = 0;
          shipx = ex+920;
          shipy = ey+yoff;
          moved = true;
        }
      }
    }
  }
}

void menu() {
  stroke(0);
  strokeWeight(1);
  fill(255, 0, 0);
  pushMatrix();
  translate(920, mapy);
  if (chapter == 1 || chapter == 2) { 
    mapy = 460;
  } else if (chapter == 3) { 
    mapy = 100;
    if(!shipPositioned){
      shipx = 729;
      shipy = 362;
      paths[level].moved = true;
      shipPositioned = true;
    }
  } else if (chapter == 4) { 
    mapy = -150;
    if(!shipPositioned){
      shipx = 520;
      shipy = 545;
      paths[level].moved = true;
      shipPositioned = true;
    }
  }
  image(map, 0, 0, 1920*scale, 1280*scale);
  ellipse(360-920, 172-460, 10, 10); //nantucket point
  for (int i=0; i<paths.length; i++) {
    paths[i].display();
    if (levelCleared[i]) {
      if (!paths[i].revealed && (level-1)%3 != 0 || !paths[i].revealed && level == 1) { 
        paths[i].moveShip = true;
      }
      paths[i].revealed = true;
    }
  }
  popMatrix();
  lvlMarker.display();
  if (prompt == 0) {
    fill(0, 70);
    stroke(0, 70);
    rect(width/2, height/2, width, height);
  }
  image(ship, shipx, shipy-30, 2*30, 2*34);
  //version info
  fill(0);
  textSize(10);
  text("Release v2.0", 40, height-10);
  //money
  fill(200, 100);
  int factor = 10, inc = 0;
  while(money/factor != 0){
    factor *= 10;
    inc ++;
  }
  rect(width/2, 30, 250+10*inc, 70);
  if(chapter > 1){
    toCredits.display();
    //settings
    fill(255, 150);
    stroke(0);
    strokeWeight(1);
    rect(width-150, height-150, 150, 80);
    fill(0);
    text("Music", width-150, height-170);
    if(music){
      fill(0, 255, 0);
      text("ON", width-150, height-140);
    } else {
      fill(255, 0, 0);
      text("OFF", width-150, height-140);
    }
    if(mouseX >= width-225 && mouseX <= width-75 && mouseY >= height-190 && mouseY <= height-110){
      fill(0, 50);
      rect(width-150, height-150, 150, 80);
      if(mouseReleased && mousePressed && chapter > 1){
        music = !music;
        vChange = true;
      }
    }
  }
  if(vChange){
    if(music){ sailingBg.amp(1);}
    else{ sailingBg.amp(0);}
    vChange = false;
  }
  if(chapter == 1){
    image(peleg, pelegx, pelegy, 400, 400);
      fill(255);
      stroke(0);
      rect(width/2, height-150, 600, 200);
      textSize(25);
      fill(0);
    if(level == 0) {
      if(failure){text("Blast ye! Go back and get that whale!", width/2, height-160);}
      else{text(tutorialPrompts[prompt], width/2, height-160);}
    } else if(level == 1){
      if(success){text(tutorialPrompts[prompt], width/2, height-160);}
    }
      textSize(15);
      text("(Click to continue)", width/2, height-80);
  }
  if (levelCleared[level]) {
    int off=0;
    if (chapter == 1 || chapter == 2) { 
      off = yoff1;
    } else if (chapter == 3) { 
      off = yoff2;
    } else if (chapter == 4) { 
      off = yoff3;
    }
    if(level != 9){
      lvlMarker.x = paths[level].ex+75+xoff;
    } else {
      lvlMarker.x = paths[level].ex-75+xoff;
    }
    lvlMarker.y = paths[level].ey+off;
  }
  fill(0);
  textSize(20);
  text("Value of oil on board: $" +money, width/2, 20);
  text("Your lay: $"+money/300, width/2, 40);
  if (mousePressed && mouseReleased && !transitioning) {
    if (prompt == 0) {
      levelCleared[0] = true;
      prompt++;
    }
    if(level == 1 && success && chapter == 1){
      chapter ++;
      transitioning = true;
      transitionTo = 5;
      transitionType = 2;
    }
  }
  if (level == 0 && pelegx < 150 && !transitioning) {
    pelegxs = 15;
  } else {
    pelegxs = 0;
  }
  if ((lvlMarker.clicked() || mousePressed && mouseReleased && TAS) && paths[level].moved ) {
    if(chapter > 1 && !transitioning || !success){
      transitioning = true;
      transitionType = 1;
      transitionTo = 3;
      if(level > 1 && (int)random(0, 100) < lookout.wisChance){
        quote = (int)random(0, 12);
      } else {
        quote = 13;
      }
      level ++;
      if(level == 1 && !failure){
        prompt ++;
      }
      lookout.used = false;
      for(int i=0; i <spouts.length; i++){
        spouts[i].wrong = false;
      }
      resetSpouts();
    }
  }
  if(toCredits.pressed() && paths[level].moved && chapter > 1 && !transitioning){
    transitioning = true;
    transitionType = 0;
    transitionTo = 8;
  }
  shipx += shipxs;
  shipy += shipys;
  pelegx += pelegxs;
  pelegy += pelegys;
}
void setHarpoonGame() {
  transitioning = true;
  transitionType = 1;
  transitionTo = 4;
  resetHarpoons();
  success = false;
  failure = false;
  scrollBack = true;
  murdInt = false;
  fails = 0;
  captureChance = 0;
  if(harpooner.p == 4){ maxHarpoons = 4;}
  else { maxHarpoons = 3;}
  w.x = whaleStartx[level];
  w.targetX = whaleStartx[level]-w.w/4;
  w.fast = false;
  if ((level-1)%3 == 0 && level > 1) { 
    w.t = 2;
  }
  w.worth = (int)random(1000, 100000);
}
void credits(){
  background(0);
  fill(255);
  textSize(50);
  text("CREDITS:", width/2, 125);
  textSize(30);
  text("Graphic Design:", width/2, 250);
  text("Scripting:", width/2, 475);
  text("Alpha/Beta Testers:", width/2, 600);
  textSize(20);
  text("Harpooner faces - Jeanie Liang", width/2-300, 300);
  text("Animated spouts - Aili McGregor", width/2+300, 300);
  text("Maps - freeworldmaps.com", width/2-300, 350);
  text("Character sketches - Rhapsody in Books Blog", width/2+300, 350);
  text("Whales/Ship - Various clipart libraries", width/2-300, 400);
  text("Old parchment backgrounds - Indiana Jones", width/2+300, 400);
  text("Whale puns and font input - Dean Woods", width/2-300, 525);
  text("Moby-Dick - Herman Melville", width/2+300, 525);
  text("Dean Woods", width/2-300, 650);
  text("Preston Brinker (Developer)", width/2+300, 650);
  textSize(10);
  text("(Click to continue)", width/2, height-50);
  if(mousePressed && mouseReleased){
    transitioning = true;
    transitionType = 1;
    transitionTo = 2;
  }
}
