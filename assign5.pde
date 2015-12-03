PImage bg1, bg2, end1, end2, enemy1, fighter, hp, start1, start2, treasure;
final int GAME_START=1, GAME_RUN=2, GAME_OVER=3;  
final int levelC=4, levelB=5, levelA=6;
int gameState;

//gamebackground
int bg1X, bg2X, bg3X;

//fighter
float fighterX, fighterY;
int fighterSpeed = 5;

//fightermove
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//hp
int hpLong;

//enemy
int [] enemyX = new int [8];
int [] enemyY = new int [8];
int enemyWidth, enemyHeight, restartX, restartY;
int enemySpeed;
int enemySpacing;
boolean [] crashing = new boolean [8];


//treasure
int treasureX, treasureY;



void setup(){
  size(640,480);
  colorMode(RGB);
  
  gameState = GAME_START;
  
  //image
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  enemy1 = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  treasure = loadImage("img/treasure.png");
  
  //background
  bg1X=0;
  bg2X=0;
  
  //fighter
  fighterX = 640-62;
  fighterY = 240;
  
  //hp
  hpLong = 50;
  
  //enemy
  enemyY[0] = floor(random(0,height-enemyHeight));
  enemySpeed = 5;
  enemyWidth = 61;
  enemyHeight = 61;
  enemySpacing = 2;
  restartX = -enemyWidth;
  restartY = floor(random(0,height-enemyHeight));

  
  //treasure
  treasureX = floor(random(0,640-41));
  treasureY = floor(random(0,480-41));
  
  
}

void draw(){
  switch(gameState){
    case GAME_START: //start
    image(start2,0,0);
    if (mouseX > 200 && mouseX < 454 && mouseY > 372 && mouseY < 415){
      if (mousePressed){
        //click
        gameState = GAME_RUN;
      }else{
      image(start1,0,0);}
    }
    break;
    
    case GAME_RUN: //run
    //background

    bg1X =(bg1X+1)%1280;
    image(bg1,bg1X,0);
    bg2X =(bg1X-640+1)%1280;
    image(bg2,bg2X,0);
    bg3X =(bg2X-640+1)%1280;
    image(bg1,bg3X,0);
    
    // figtermove
    image(fighter, fighterX, fighterY);
    if (upPressed){
    fighterY = fighterY-fighterSpeed;
    if(fighterY<0){
      fighterY=0;
    }
  }
    if (downPressed){
    fighterY = fighterY+fighterSpeed;
      if(fighterY>419){
        fighterY=419;}
    }
    if (leftPressed){
    fighterX = fighterX-fighterSpeed;
       if(fighterX<0){
         fighterX=0;}
  }
    if (rightPressed){
    fighterX = fighterX+fighterSpeed;
      if(fighterX>579){
        fighterX=579;}
    }  
    
    
    
    //hp
    rectMode(CORNERS);
    rect(10,9,hpLong,25);
    fill(255,0,0);
    stroke(255,0,0);
    image(hp,2,5);
    if(hpLong >= 210){
    hpLong = 210;}
    
    //enemy
    
    //crash
    
    for(int i=0; i<8; i++){
      if(fighterX >= enemyX[i] && fighterX <= enemyX[i]+enemyWidth && fighterY >= enemyY[i] && fighterY <= enemyY[i]+enemyHeight){
        hpLong -= 20;}
        else if(fighterX+enemyWidth >= enemyX[i] && fighterX+enemyWidth <= enemyX[i]+enemyWidth && fighterY+enemyHeight >= enemyY[i] && fighterY+enemyHeight <= enemyY[i]+enemyHeight){
        hpLong -= 20;}
    }
    
    
    
    //level C
    restartX+=enemySpeed;
    for(int i=0; i<5; i++){
      enemyX[i] = restartX - i*(enemyWidth+enemySpeed);
      enemyY[i] = restartY;
      image(enemy1,enemyX[i],enemyY[i]);
    }
   

 
    //level B
    for(int i=0; i <5; i++){
      enemyX[i] = -(width+enemyWidth*5+enemySpacing*5)+restartX-i*(enemyWidth+enemySpacing);
      enemyY[i] = restartY+i*enemyWidth/2;
      image(enemy1,enemyX[i],enemyY[i]);
    }
    
    //level A
    for(int i=0; i<8; i++){
      if(i<3){
        enemyX[i] = -2*(width+enemyWidth*5+enemySpacing*5)+restartX-i*(enemyWidth+enemySpacing); 
        enemyY[i] = restartY+i*enemyWidth;
        image(enemy1,enemyX[i],enemyY[i]);
      }else if(i>=3&&i<6){
        enemyX[i] = -2*(width+enemyWidth*5+enemySpacing*5)+restartX-(i-2)*(enemyWidth+enemySpacing);
        enemyY[i] = restartY-(i-2)*enemyWidth;
        image(enemy1,enemyX[i],enemyY[i]);
      }
      else if(i>=6&&i<8){
        enemyX[i] = -2*(width+enemyWidth*5+enemySpacing*5);
        enemyY[i] = enemyY[4];
        image(enemy1,enemyX[i],enemyY[i]);
      }
    
    }
    
    /*if(enemyX[4]>width || enemyX[5]>width){
      restartY= floor(random(0,height-enemyHeight));
    }*/
    restartX %= width*3+(enemyWidth+enemySpacing)*5*3;
 
   
   //level A
   /*int Xmoving = enemyWidth*2+enemySpacing*2;
   int Ymoving = -enemyHeight*2;
   
   for(int i=0; i<3; i++){
     int x= enemyA[0]-i*(enemyWidth+enemySpacing);
     int y= enemyY3+i*(enemyHeight);
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   for(int i=0; i<3; i++){
     int x= enemyA[0]-i*(enemyWidth+enemySpacing)-Xmoving;
     int y= enemyY3+i*(enemyHeight)+Ymoving;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   } 
   
   for(int i =6; i<7; i++){
     int x= enemyA[0]-Xmoving/2;
     int y= enemyY3+Ymoving/2;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   for(int i =7; i<8; i++){
     int x= enemyA[0]-Xmoving*3/2;
     int y= enemyY3-Ymoving/2;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   if(enemyA[2]>width){
    enemyY3 = floor(random(enemyHeight*2,height-enemyHeight*5));}
    enemyA[0] += enemySpeed;
    enemyA[0] %= width*3+(enemyWidth*10+enemySpacing*6);
    */
  
  
   
   
 
    
    
   
    

  
    
    //treasure
    image(treasure, treasureX, treasureY);
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
    hpLong += 20;}
    else if(fighterX+51 >= treasureX && fighterX+51 <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    hpLong += 20;}
    else if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    hpLong += 20;}
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
     treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    else if(fighterX+51 >= treasureX && fighterX+51 <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    else if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    
    //die
    if(hpLong <= 10){
    gameState = GAME_OVER;}
    
    break;
    
    case GAME_OVER: //gameover
    image(end1,0,0);
    if (mouseX >= 204 && mouseX < 434 && mouseY >= 306 && mouseY <= 350){
      if(mousePressed){
        gameState = GAME_RUN; fighterX = 580 ; fighterY = 240; hpLong = 50;
      }
    }
    else{image(end2,0,0);}
    break;
  }
}



void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }
  
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }

}
