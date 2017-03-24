class Comet {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Comet(PVector l) {

    //For demonstration purposes we assign the Comet an initial velocity and constant acceleration.

    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1)*25, random(-2, 2));
    location = l.get();
    lifespan = 255.0;
  }


  //Sometimes it’s convenient to have a “run” function that calls all the other functions we need.

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }

  void display() {
    stroke(255,0,255, lifespan);
    fill(255,lifespan,64, lifespan);
    triangle(location.x, location.y, location.x,location.y+8, location.x+lifespan, location.y);

  }


  //Is the Comet alive or dead?

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}