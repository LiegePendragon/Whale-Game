Spout[] spouts = new Spout[9];
boolean[] taken = new boolean[9];
boolean set, shown;
int watery = 400, watery2 = watery-1024;
int quoteChance, quote;

void lookoutGame(int lvl) {
  background(#9999ff);
  watery ++;
  watery2 ++;
  if (watery >= height+512) { 
    watery = watery2-water.height;
  }
  if (watery2 >= height+512) { 
    watery2 = watery-water.height;
  }
  image(water, width/2, watery, width, water.height);
  image(water, width/2, watery2, width, water.height);
  if (!set) {
    setSpoutPos(lvl);
    set = true;
  }
  for (int i=0; i<spouts.length; i++) {
    spouts[i].display();
    //if using TAS, flash cursor to correct spout
    if(TAS && spouts[i].t == 2 && !shown){
      mouseX = spouts[i].x;
      mouseY = spouts[i].y;
      shown = true;
    }
  }
  if (lvl == 1) {
    if (prompt <= 3) {
      fill(0, 100);
      stroke(0, 100);
      rect(width/2, height/2, width, height);
      fill(255);
      stroke(0);
      rect(width/2, height-150, 600, 200);
      textSize(25);
      fill(0);
      text(tutorialPrompts[prompt], width/2, height-160);
      textSize(15);
      text("(Click to continue)", width/2, height-80);
      image(peleg, pelegx, pelegy, 400, 400);
    }
  }
  if(quote < 12){
    displayQuote(quote);
  }
  if(mousePressed && mouseReleased && TAS && prompt > 3){
    w.t = 1;
    setHarpoonGame();
  }
  for (int i=0; i<spouts.length; i++) {
    if (spouts[i].clicked() && prompt > 3) {
      //lim is murderous intent chance
      int lim;
      if (lookout.p == 2) {
        lim = 1;
        if (lookout.synergy) {
          lim = 5;
        }
      } else { 
        lim = 0;
      }
      //check spouts
      if (spouts[i].t == 2) {
        w.t = 1;
        setHarpoonGame();
        if ((level-1)%3 != 0 && level > 1 && (int)(random(0, 100)) < lim) {
            success = true;
            murdInt = true;
          }
      } else {
        if (lookout.p == 0 && !lookout.used) {
          lookout.used = true;
          spouts[i].wrong = true;
        } else {
          w.t = 0;
          setHarpoonGame();
          if ((level-1)%3 != 0 && level > 1 && (int)(random(0, 100)) < lim) {
            success = true;
            murdInt = true;
          }
        }
      }
      pelegy = 220;
    }
  }
  if (mousePressed && mouseReleased && prompt <= 3) {
    prompt ++;
  }
}
void setSpoutPos(int l) {
  //set amount of spouts based on level
  int amount = 3;
  if (chapter > 1) {
    amount = l+4-chapter;
  }
  if(amount > 9){
    amount = 9;
  }
  //randomize positioning
  for (int i=0; i<amount; i++) {
    int r = (int)random(0, 9);
    while (taken[r]) {
      r = (int)random(0, 9);
    }
    taken[r] = true;
    spouts[i].pos = r;
  }
  //randomize which is correct
  spouts[(int)random(0, amount)].t = 2;
  shown = false;
}
void resetSpouts() {
  for (int i=0; i<spouts.length; i++) { 
    taken[i] = false;
    spouts[i].t = 1;
  }
  set = false;
}
void displayQuote(int r){
  fill(255);
  strokeWeight(1);
  stroke(0);
  rect(width-170, 200, 300, 200);
  fill(0);
  textSize(30);
  text(lookout.name+" says:", width-170, 150);
  textSize(20);
  textAlign(CENTER, TOP);
  if(lookout.p == 0){
    text(iQuotes[r], width-170, 175);
  } else if(lookout.p == 1){
    text(sQuotes[r], width-170, 175);
  }
  textAlign(CENTER, CENTER);
}
