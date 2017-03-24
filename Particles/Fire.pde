// A simple Particle class

class Fire {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  


  Fire(PVector l) {
    acceleration = new PVector(0, 0.15);
    velocity = new PVector(random(-2, 2), random(-8, -2));
    position = l.copy();
    lifespan = 64.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255-lifespan, 64+lifespan*2, 0, lifespan*2);
    
    arc(position.x, position.y, random(-lifespan*2), lifespan, radians(random(-360)), radians(random(-340)), OPEN);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}