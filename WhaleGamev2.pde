
/******************* Changelog **********************
               Release Version 2.0
               
   - Bug Fixes

***************************************************/
import processing.sound.*;

boolean quickLoad = false;

SoundFile hackerSong;
SoundFile sailingBg;
int mode = -1, chapter = 1, pmode;
String keyInputs="";
boolean mouseReleased=true, keyReleased=true, music=true, vChange;
String[] portraitNames = {"Ishmael.jpg", "Starbuck.png", "Flask.gif", "Queequeg.gif", "Ahab.jpg", "Daggoo.gif"};
PImage[] portraits = new PImage[6];
PImage[] heads = new PImage[3];
String[] headNames = {"QueequegHead.png", "AhabHead.png", "DaggooHead.png"};
PImage[] hackerman = new PImage[72];
PImage[] goodSpout = new PImage[24];
PImage[] badSpout = new PImage[24];
PImage water; //1024x1024
PImage waves; //260x187
PImage transitionImage; //300x238
PImage oldMap, parchment;
PImage cursor;
PImage whale, whiteWhale; //3500x1800, 295x170
PImage hackerFace, scaredFace;
PFont AhabWriting, IshmaelWriting, normal;
float loadWidth=0;
float images = 145;
int imgLoaded, audioLoaded;
boolean transitioning;
int transitionTo, transitionType;
int money;
boolean revealHitboxes, murdInt, TAS;
int ha, hx, hy;
long timer;
PC harpooner, lookout;
void loadImages(){
  cursor = loadImage("cursor.png");
  loadWidth += 240/images;
  imgLoaded ++;
  for(int i=0; i<hackerman.length; i++){
    hackerman[i] = loadImage("h"+i+".png");
    loadWidth += 240/images;
    imgLoaded ++;
  }
  for(int i=0; i<goodSpout.length; i++){
    goodSpout[i] = loadImage("gs"+i+"-removebg-preview.png");
    loadWidth += 240/images;
    imgLoaded ++;
  }
  for(int i=0; i<badSpout.length; i++){
    badSpout[i] = loadImage("bs"+i+"-removebg-preview.png");
    loadWidth += 240/images;
    imgLoaded ++;
  }
  hackerFace = loadImage("hacker face.png");
  loadWidth += 240/images;
  imgLoaded ++;
  scaredFace = loadImage("Scared Ahab.png");
  loadWidth += 240/images;
  imgLoaded ++;
  for(int i=0; i<headNames.length; i++){
    heads[i] = loadImage(headNames[i]);
    loadWidth += 240/images;
    imgLoaded ++;
  }
  waves = loadImage("waves.gif");
  loadWidth += 240/images;
  imgLoaded ++;
  whale = loadImage("whale.png");
  loadWidth += 240/images;
  imgLoaded ++;
  whiteWhale = loadImage("white whale.png");
  loadWidth += 240/images;
  imgLoaded ++;
  transitionImage = loadImage("cute white whale.png");
  loadWidth += 240/images;
  imgLoaded ++;
  water = loadImage("water.jpg");
  loadWidth += 240/images;
  imgLoaded ++;
  whaleSilhouette = loadImage("whale silhouette.png");
  loadWidth += 240/images;
  imgLoaded ++;
  rWhaleSilhouette = loadImage("whale silhouette.png");
  loadWidth += 240/images;
  imgLoaded ++;
  rwsc = loadImage("whale silhouette.png");
  loadWidth += 240/images;
  imgLoaded ++;
  map = loadImage("map.jpg");
  loadWidth += 240/images;
  imgLoaded ++;
  oldMap = loadImage("old map.JPG");
  loadWidth += 240/images;
  imgLoaded ++;
  parchment = loadImage("Parchment.jpg");
  loadWidth += 240/images;
  imgLoaded ++;
  ship = loadImage("ship.png");
  loadWidth += 240/images;
  imgLoaded ++;
  peleg = loadImage("peleg.png");
  loadWidth += 240/images;
  imgLoaded ++;
  for(int i=0; i<portraitNames.length; i++){
    portraits[i] = loadImage(portraitNames[i]);
    loadWidth += 240/images;
    imgLoaded ++;
  }
  if(quickLoad){
    mode = 0;
  }
}
void loadSongs(){
  sailingBg = new SoundFile(this, "Sailing Background.mp3");
  sailingBg.amp(0.75);
  audioLoaded ++;
  hackerSong = new SoundFile(this, "hacker song.mp3");
  audioLoaded ++;
  loadWidth = 480;
  transitioning = true;
  transitionType = 0;
  transitionTo = 0;
  sailingBg.loop();
}
void setup(){
  fullScreen(P2D);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  noCursor();
  AhabWriting = loadFont("AhabScript.vlw");
  IshmaelWriting = loadFont("IshmaelScript.vlw");
  normal = loadFont("normal.vlw");
  textFont(normal);
  textSize(15);
  if(!quickLoad){
    thread("loadSongs");
  }
  toCredits = new Button("Credits", width-150, height-75, 150, 50, color(255, 150));
  p1 = new CharacterPanel(pcs[0], width/2-300, height/2);
  p2 = new CharacterPanel(pcs[1], width/2, height/2);
  p3 = new CharacterPanel(pcs[2], width/2+300, height/2);
  c1 = new Cloud(400, 300);
  c2 = new Cloud(700, 400);
  c3 = new Cloud(width, 100);
  c4 = new Cloud(width-200, 350);
  thread("loadImages");
  boatX = 150;
  boatY = 675;
  pelegx = -200;
  pelegy = height-200;
  for(int i=0; i<harpoons.length; i++){
    harpoons[i] = new Harpoon(-100, -100, 10);
  }
  for(int i=0; i<stars.length; i++){
    stars[i] = new Star((int)random(5, width-5), (int)random(5, height/2), 0);
  }
  for(int i=0; i<spouts.length; i++){
    spouts[i] = new Spout(-100, -100, 1);
  }
}

void draw(){
  try{
  if(mode < 0){
    background(0);
    stroke(255);
    noFill();
    rect(width/2, height/2, 480, 50, 25);
    rectMode(CORNER);
    fill(#00ff00);
    noStroke();
    rect(width/2-240, height/2-24, loadWidth, 49, 25);
    rectMode(CENTER);
    if(imgLoaded < images){
      text("Loading visual assets "+imgLoaded+"/"+(int)images, width/2, height/2+50);
    } else {
      text("Loading audio files "+audioLoaded+"/2", width/2, height/2+50);
      //completely manual "loading bar" for audio, syncs up but doesn't follow actual loading pattern
      if(loadWidth < 470){
        if(frameCount%3 == 0){ loadWidth += 0.4;}
        if(frameCount%40 == 0){ loadWidth += 1.5;}
        if(frameCount%250 == 0){ loadWidth += 5;}
      }
    }
  }
  if(mode == 0){ titleScreen();}
  else if(mode == 1){ characterSelect();}
  else if(mode == 2){ menu();}
  else if(mode == 3){ lookoutGame(level);}
  else if(mode == 4){ harpoonGame(level);}
  else if(mode == 5){ letters();}
  else if(mode == 6){ endScreen();}
  else if(mode == 7){ hackeryHackerman();}
  else if(mode == 8){ credits();}
  if(transitioning){ transition(transitionTo, transitionType);}
  } catch (Exception e){
    background(0);
    fill(255, 0, 0);
    textSize(150);
    text("ERROR!", width/2, height/2);
    delay(500);
    exit();
  }
  if(mode != 7){
    try{
      image(cursor, mouseX+10, mouseY+10, 30, 30);
    } catch (Exception e){}
  }
  if(mousePressed){
    mouseReleased = false;
  }
  if(keyPressed && keyReleased && mode != 7){
    keyInputs += key;
  }
  if(keyPressed){
    keyReleased = false;
  }
  if(keyInputs.contains("/")){
    revealHitboxes = false;
    TAS = false;
  }
  if(keyInputs.contains("hacker")){
    pmode = mode;
    mode = 7;
    sailingBg.pause();
    hackerSong.cue(0);
    hackerSong.play();
    ha = 0;
    hx = 0;
    hy = 0;
    timer = millis();
    keyInputs = "";
  }
  if(keyInputs.contains("h4cker")){
    revealHitboxes = !revealHitboxes;
    keyInputs = "";
  }
  if(keyInputs.contains("mute") && mode != 0){
    sailingBg.amp(0);
    keyInputs = "";
  }
  if(keyInputs.contains("TAS")){
    TAS = !TAS;
    keyInputs = "";
  }
  if(keyInputs.length() >= 100){ 
    keyInputs = "";
  }
}

void mouseClicked(){
  //doing harpoon game mouse clicks in here cuz I started here and I don't wanna change it
  if(mouseX <= width-25 && mouseX >= width-75 && mouseY <= height-25 && mouseY >= height-75 && mode == 4 && prompt > 9){
    if(worldX == -w.x+width/2){ scrollBack = true;}
    if(worldX == 0){ lookAtWhale = true;}
  } else if(!harpoons[hi].launched && !scrollBack && !success && !failure && mode == 4 && mouseReleased && prompt > 9 && !w.move){
    harpoons[hi].toss();
  }
  if(prompt <= 9 && mode == 4){
    prompt ++;
  }
}
void mouseReleased(){
  mouseReleased = true;
}
void keyReleased(){
  keyReleased = true;
}

void hackeryHackerman(){
  background(0);
  int t = 2;
  image(hackerman[(frameCount%(72*t))/t], -100+hx, height/2);
  image(hackerman[(frameCount%(72*t))/t], width+100-hx, height/2);
  colorMode(HSB);
  textFont(normal);
  textSize(60);
  fill(frameCount%255, 255, 255);
  text("JEBAITED", width/2, -100+hy);
  text("JEBAITED", width/2, height+100-hy);
  tint(255, ha);
  image(hackerFace, width/2, height/2);
  noTint();
  ha += 1;
  if(millis()-timer >= 6000 && hx < 300){
    hx ++;
  }
  if(millis()-timer >= 20500 && hy < 200){
    hy += 5;
  }
  if(millis()-timer >= 37000 && !transitioning){
    transitioning = true;
    transitionTo = pmode;
    transitionType = 0;
    sailingBg.loop();
  }
  colorMode(RGB);
}
