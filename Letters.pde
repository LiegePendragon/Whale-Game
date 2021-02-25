int la=100, las=3;
void letters(){
  background(#ebd5b3);
  image(parchment, width/2, height/2, width, height);
  if(chapter < 4){ AhabText();}
  if(chapter == 4){ epilogue();}
  textAlign(CENTER, CENTER);
  textFont(normal);
  textSize(15);
  fill(0, la);
  text("(Click to continue)", width/2, height-50);
  if(la < 100 || la > 200){ las = -las;}
  la += las;
  if(mousePressed && mouseReleased && !transitioning){
    if(chapter < 4){
      transitioning = true;
      transitionTo = 2;
      transitionType = 0;
    }
    if(chapter == 4){
      transitioning = true;
      transitionTo = 6;
      transitionType = 0;
      timer = millis();
    }
  }
}

void epilogue(){
  textFont(IshmaelWriting);
  textAlign(LEFT, TOP);
  textSize(30);
  fill(0);
  textLeading(45);
  text("The drama's done. Moby-Dick continued forward and, with a\nseeming malice, struck the Pequod herself. "+
  "Why then does anyone\nstep forth? Because one did survive the wreck. By chance and the\nFates I was dropped astern "+
  "when that first dart flew. And so I\nwatched, floating on the margin of the ensuing scene, as the Pequod\n"+
  "disappeared in a vortex. I survived only by happening across a\ncoffin-turned-life buoy, staying afloat for two days "+
  "until the\nwhaling ship Rachel, searching for her missing children, found\nonly another orphan.", 100, 100);
  text("Ishmael", 100, 550);
}

void AhabText(){
  textFont(AhabWriting);
  textAlign(LEFT, TOP);
  textSize(40);
  fill(0);
  textLeading(40);
  text("To   my   brave   crew :", 100, 80);
  text("What   do   ye   do   when   ye   see   a   whale ?   Sing   out   for   him !\nWhat   do   ye   do   next ?   Lower   away,   and   after   him !   "+ 
       "What   tune\nis   it   ye   pull   to ?   A   dead   whale   or   a   stove   boat !   So   I   now\ncharge   ye   to   do   the   same   with   "+
       "this   white   whale .   I   have   a\nSpanish   doubloon ,   and   whosoever   of   ye   raises   me   that\nwhite-headed   whale   "+
       "with   a   wrinkled   brow   and   a   crooked\njaw,   with   three   holes   punctured   in   his   starboard   fluke ,   he\nshall   "+
       "have   this   gold   ounce !   Some   call   this   whale   Moby-Dick,\nand   this   is   the   one   that   dismasted   me   "+
       "previously .  This   is   our\ntrue   purpose,   men!   We   must   hunt   down   Moby-Dick   until   he\nspouts   "+
       "black   blood   and   rolls   fin   out!   Let   us   splice\nhands   on   it ,   I   think   ye   do   look   brave !", 100, 150);
  textSize(70);
  textAlign(CENTER, CENTER);
  fill(#660000);
  pushMatrix();
  translate(width/2, 680);
  rotate(radians(-10));
  text("Captain    Ahab", 0, 0);
  popMatrix();
}
