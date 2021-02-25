PC[] pcs = {new PC(0), new PC(1), new PC(2), new PC(3), new PC(4), new PC(5)};
CharacterPanel p1;
CharacterPanel p2;
CharacterPanel p3;
int selection = 0;
String[] iQuotes = {"All mortal greatness is but\ndisease.",
                    "As everyone knows, meditation\nand water are wedded forever.",
                    "Better to sleep with a sober\ncannibal than a drunk Christian.",
                    "Ignorance is the parent of fear.",
                    "We are all somehow dreadfully\ncracked about the head, and\nsadly need mending.",
                    "Call me Ishmael.",
                    "No great and enduring volume\ncan ever be written on the flea,\nthough many there be who have\ntried it.",
                    "The world is a book. Can you\nread it?",
                    "Living close to nature is\nwonderful for your mental health.",
                    "There is a wisdom that is woe,\nbut there is a woe that is\nmadness.",
                    "Would you like to hear a 50-page\ndissertation on whale heads?",
                    "Isn't Queequeg just the best?"};
String[] sQuotes = {"Let faith oust fact; let fancy\noust memory; I look deep down\nand do believe.",
                    "To be enraged with a dumb thing\nseems blasphemous.",
                    "A gentle answer turns away wrath,\nbut a harsh word stirs up\nanger.",
                    "My soul is more than matched;\nshe's overmanned; and by\na madman!",
                    "God keep us all!",
                    "O ye blessed influences, stand\nby me, hold me, bind me!",
                    "Do unto others as you would have\nthem do unto you.",
                    "Disgrace comes with pride, but\nwith humility comes wisdom.",
                    "How many barrels will revenge\nfetch to sell at market?",
                    "Those who hope in the Lord will\nrenew their strength.",
                    "Love God with all your heart and\nall your soul and all your\nmind.",
                    "What good will it be for a man if\nhe gains the whole world,\nyet forfeits his soul?"};

class Button{
  int x, y, w, h;
  String t;
  color c;
  Button(String text, int tx, int ty, int tw, int th, color tc){
    t = text;
    x = tx;
    y = ty;
    w = tw;
    h = th;
    c = tc;
  }
  void display(){
    fill(c);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
    fill(0);
    textSize(20);
    text(t, x, y);
    if(mouseOver()){
      noStroke();
      fill(0, 50);
      rect(x, y, w, h);
    }
  }
  boolean mouseOver() {
    if (mouseX <= x+w/2 && mouseX > x-w/2 && mouseY <= y+h/2 && mouseY >= y-h/2) {
      return true;
    } else {
      return false;
    }
  }
  boolean pressed(){
    if(mousePressed && mouseOver() && mouseReleased){
      return true;
    } else {
      return false;
    }
  }
}

class PC {
  int p;
  String name, f1, f2, f3;
  boolean synergy, used;
  int wisChance;
  String[] names = {"Ishmael", "Starbuck", "Flask", "Queequeg", "Ahab", "Daggoo"};
  String[] features1 = {"Transcendental Moment: Chance to\noffer a piece of wisdom contained\nin a confusing mess of symbols", 
    "Man of Faith: Chance to offer\na piece of Biblical advice", "Surface Level Thinking: Will not\noffer any deep insights", 
    "Mysterious Tattoos: Able to\nharpoon the tail of the whale", 
    "Monomaniac: Harpooning a whale\nbrings it slightly closer to the boat", 
    "Inner Strength: Harpoon throws\nare slightly more powerful"};
  String[] features2 = {"Plot Armor: Allowed one wrong\nguess on a spout per level", "Practicality: Earn slightly more\nmoney from sperm whales", 
    "Murderous Intent: Small chance\nto instantly capture any whale\nspotted", 
    "Yojo's Guidance: Increased chance\nto capture a whale if a harpoon hits", 
    "Laser Focus: Gain an extra harpoon\nfor the first throw of each level", 
    "Level Head: Ignores the rocking\nof the boat when throwing\nharpoons"};
  String[] features3 = {"Seeker of Spiritual Knowledge", "Pacifist", "Fight Over Flight", 
    "Spiritual Advisor", "Position of Command", "Calm in the Storm"};
  PImage portrait;
  PC(int person) {
    p = person;
    name = names[p];
    f1 = features1[p];
    f2 = features2[p];
    f3 = features3[p];
    if(p == 0 || p == 1){ wisChance = 40;}
    else { wisChance = 0;}
  }
  void update() {
    if(harpooner != null && lookout != null){
      if(harpooner.p == 3 && lookout.p == 0 || harpooner.p == 4 && lookout.p == 1 || harpooner.p == 5 && lookout.p == 2){
        synergy = true;
      }
    }
    portrait = portraits[p];
    if(synergy && (p == 0 || p == 1)){
      wisChance = 80;
    }
  }
}
class CharacterPanel {
  PC c;
  Button b;
  int x, y, w, h, xs;
  int px;
  CharacterPanel(PC tc, int tx, int ty) {
    c = tc;
    x = tx;
    y = ty;
    w = 300;
    h = 550;
    px = x;
    xs = 0;
    b = new Button("Select", x, y+335, 200, 75, color(255));
  }
  void display() {
    c.update();
    fill(100, 150);
    rect(x, y, w, h);
    fill(255);
    textSize(40);
    text(c.name, x, y-200);
    textSize(19);
    text(c.f1, x, y-100);
    text(c.f2, x, y);
    text(c.f3, x, y+100);
    noFill();
    strokeWeight(1);
    stroke(0);
    rect(x, y, w, h);
    image(c.portrait, px, y, w, h);
    b.display();
    if(b.pressed()){
      if(selection == 0){ 
        lookout = c;
        selection = 1;
      } else { 
        harpooner = c;
        transitioning = true;
        transitionType = 2;
        transitionTo = 2;
        lookout.update();
        harpooner.update();
      }
    }
    px += xs;
  }
  boolean mouseOver() {
    if (mouseX <= x+w/2 && mouseX > x-w/2 && mouseY <= y+h/2 && mouseY >= y-h/2) {
      return true;
    } else {
      return false;
    }
  }
}


void characterSelect() {
  //background(200);
  tint(190);
  image(oldMap, width/2, height/2, width, height);
  noTint();
  textSize(40);
  fill(255);
  if(selection == 0){ 
    text("Choose yer lookout!", width/2, 60); 
    p1.c = pcs[0];
    p2.c = pcs[1];
    p3.c = pcs[2];
  } else { 
    text("Choose yer harpooner!", width/2, 60);
    p1.c = pcs[3];
    p2.c = pcs[4];
    p3.c = pcs[5];
  }
  p1.display();
  p2.display();
  p3.display();
  if(!p3.mouseOver() && p3.px < p3.x){ p3.xs = 25;}
  else if(p3.px >= p3.x || p3.px <= p3.x-300){ p3.xs = 0;}
  if(!p2.mouseOver() && !p3.mouseOver() && p2.px < p2.x){ p2.xs = 25;}
  else if(p2.px >= p2.x || p2.px <= p2.x-300){ p2.xs = 0;}
  if(!p1.mouseOver() && !p2.mouseOver() && !p3.mouseOver() && p1.px < p1.x){ p1.xs = 25;}
  else if(p1.px >= p1.x || p1.px <= p1.x-300){ p1.xs = 0;}
  if(p3.mouseOver() && p3.px > p3.x-300){
    p3.xs = -25;
    if(p2.px == p2.x){ p2.xs = -25;}
    if(p1.px == p1.x){ p1.xs = -25;}
  } else if(p2.mouseOver() && p2.px > p2.x-300){
    p2.xs = -25;
    if(p1.px == p1.x){ p1.xs = -25;}
  } else if(p1.mouseOver() && p1.px > p1.x-300){
    p1.xs = -25;
  }
}
