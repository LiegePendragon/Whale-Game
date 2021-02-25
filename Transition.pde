float transitionWhaleSize=0;
float twsSpeed = 0.3;
int transAlpha, tas = 10;
String[] chapterNames = {"Welcome to Whaling", "A Fateful Encounter", "Pursuit", "Revenge"};
int chapterTimer;


void transition(int m, int t) {
  if (t == 1) {
    image(transitionImage, width/2+30*transitionWhaleSize, height/2, transitionImage.width*transitionWhaleSize, transitionImage.height*transitionWhaleSize);
    transitionWhaleSize += twsSpeed;
    twsSpeed += 0.03;
    if (transitionWhaleSize >= 15) {
      transitionWhaleSize = 15;
      twsSpeed = -twsSpeed;
      mode = m;
    }
    if (transitionWhaleSize <= 0) {
      transitionWhaleSize = 0;
      twsSpeed = -twsSpeed;
      transitioning = false;
    }
  } else if(t == 2){
    chapterTransition(m);
  }else {
    stroke(0, transAlpha);
    fill(0, transAlpha);
    rect(width/2, height/2, width, height);
    transAlpha += tas;
    if (transAlpha >= 255) {
      tas = -tas;
      mode = m;
    }
    if (transAlpha < 0) {
      transAlpha = 0;
      tas = -tas;
      transitioning = false;
    }
  }
}

void chapterTransition(int m) {
  stroke(0, transAlpha);
  fill(0, transAlpha);
  rect(width/2, height/2, width, height);
  fill(255, transAlpha);
  textSize(40);
  text("Chapter "+chapter+": "+chapterNames[chapter-1], width/2, height/2);
  transAlpha += tas;
  if (transAlpha >= 255) {
    transAlpha = 255;
    mode = m;
    chapterTimer ++;
    if(chapterTimer >= 90){
      tas = -tas;
    }
  }
  if (transAlpha < 0) {
    transAlpha = 0;
    tas = -tas;
    transitioning = false;
    chapterTimer = 0;
  }
  transAlpha += tas;
}
