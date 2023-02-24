int directionx;
int directiony;
float bally;
float ballx;
int gap = 30;
int paddley;
int paddlelength = 130;
int radius = 25;
boolean restart = false;
int score = 0;
float speed = 3;
int rectx;


void setup() {
  size(800, 500);
  background(180);



  // ball's starting direction and speed
  newBallDir();
  newBallPos();
}

void score() {
    fill(0);
    textSize(20);
    text("Score:", 650, 25);
    text(score, 740, 25); 
}

void newBallPos() {
    // ball's starting position
    bally = radius + 14;
    ballx = random(800);
    paddley = height - gap - 30;
}

boolean gameOver() {
  // when game ends
  if(bally > height) {
    return true;
  } else {
    return false;
  }
}

void newBallDir() {
  // to make ball going random direction
  directionx = int(random(-2,2));
  directiony = 1;
}

void acceleration() {
  // this makes sure that the balls speeds up when the speed variable increases
  bally += directiony * speed;
  ballx += directionx * speed;
}

void bounce(){
  // makes sure ball hits the walls
  if ((bally - (radius - 13)) < 0) {
    directiony = directiony * -1;
  } if ((ballx - (radius - 13)) < 0){
    directionx = directionx * -1; 
  } if ((ballx + (radius - 13)) > width){
    directionx = directionx * -1; 
  }

  // makes sure ball hits the paddle
  if(bally > (height - 85) && bally < (height - 70) && (mouseX - (paddlelength/2)) < ballx && ballx < (mouseX + (paddlelength/2))){
    directiony = directiony *- 1;
    score++;
    speed = speed + 0.4;
  }
}

void crazyRainbow() {
  // crazy rainbow activates if mouse is pressed
  if(mousePressed != true) { 
      background(180);
  }
}

void drawPaddle() {
  fill(255);
  rectMode(CENTER);
  int rectx = constrain(mouseX, 0 + (paddlelength/2), width - (paddlelength/2)); //this constrains paddle to not go outside box
  rect(rectx, paddley, paddlelength, gap);   // draws the paddle
}

void drawCircle() {
  // ball
  fill(random(255), random(255), random(255));
  circle(ballx, bally, radius);
}

void draw() {
    // crazy rainbow has to be put first because it sets the background
    if(gameOver() == false) {
        crazyRainbow();
        drawPaddle();
        drawCircle();
        acceleration();
        bounce();
        score();
    } else {
      textSize(50);
      textWidth("Game Over");
      text("Game Over", 255, 200);
      textSize(35);
      text("Press any key to start over", 170, 320); 
      noLoop(); // waits for next step (key needs to be pressed)
    }
}

void keyPressed() {
  if (gameOver() == true) {
    score = 0;
    speed = 3;
    newBallDir();
    newBallPos();
    loop(); // starts the game again
  }
}
