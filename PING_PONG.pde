Puck puck;
Paddle left;
Paddle right;

int leftscore = 0;
int rightscore = 0;

void setup() {
  size(600, 400);

  puck = new Puck();
  left = new Paddle(true);
  right = new Paddle(false);
}

void draw() {
  background(0);

  puck.checkPaddleRight(right);
  puck.checkPaddleLeft(left);

  left.show();
  right.show();
  left.update();
  right.update();

  puck.update();
  puck.edges();
  puck.show();

  fill(255);
  textSize(32);
  text(leftscore, 32, 40);
  text(rightscore, width-64, 40);
}

void keyReleased() {
  left.move(0);
  right.move(0);
}

void keyPressed() {
  if (key == 'a') {
    left.move(-10);
  } else if (key == 'z') {
    left.move(10);
  }

  if (key == 'j') {
    right.move(-10);
  } else if (key == 'm') {
    right.move(10);
  }
}

class Paddle {
  float x;
  float y = height/2;
  float w = 20;
  float h = 100;

  float ychange = 0;

  Paddle(boolean left) {
    if (left) {
      x = w;
    } else {
      x = width - w;
    }
  }

  void update() {
    y += ychange;
    y = constrain(y, h/2, height-h/2);
  }


  void move(float steps) {
    ychange = steps;
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}

class Puck {
  float x = width/2;
  float y = height/2;
  float xspeed;
  float yspeed;
  float r = 12;

  Puck() {
    reset();
  }

  void checkPaddleLeft(Paddle p) {
    if (y - r < p.y + p.h/2 && y + r > p.y - p.h/2 && x - r < p.x + p.w/2) {
      if (x > p.x) {
        float diff = y - (p.y - p.h/2);
        float rad = radians(45);
        float angle = map(diff, 0, p.h, -rad, rad);
        xspeed = 5 * cos(angle);
        yspeed = 5 * sin(angle);
        x = p.x + p.w/2 + r;
        //xspeed *= -1;
      }
    }
  }
  void checkPaddleRight(Paddle p) {
    if (y - r < p.y + p.h/2 && y + r > p.y - p.h/2 && x + r > p.x - p.w/2) {
      if (x < p.x) {
        //xspeed *= -1;
        float diff = y - (p.y - p.h/2);
        float angle = map(diff, 0, p.h, radians(225), radians(135));
        xspeed = 5 * cos(angle);
        yspeed = 5 * sin(angle);
        x = p.x - p.w/2 - r;
      }
    }
  }




  void update() {
    x = x + xspeed;
    y = y + yspeed;
  }

  void reset() {
    x = width/2;
    y = height/2;
    float angle = random(-PI/4, PI/4);
    //angle = 0;
    xspeed = 5 * cos(angle);
    yspeed = 5 * sin(angle);

    if (random(1) < 0.5) {
      xspeed *= -1;
    }
  }

  void edges() {
    if (y < 0 || y > height) {
      yspeed *= -1;
    }

    if (x - r > width) {

      leftscore++;
      reset();
    }

    if (x + r < 0) {

      rightscore++;
      reset();
    }
  }


  void show() {
    fill(255);
    ellipse(x, y, r*2, r*2);
  }
}
