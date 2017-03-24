// A simple Particle class

class Rain {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  
  Rain(PVector l) {
    acceleration = new PVector(0, .125);
    velocity = new PVector(0, 5);
    position = l.copy();
    lifespan = 100.0;
 
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= .25;
  }

  // Method to display
  void display() {
    

    stroke(255, lifespan);
    fill(0,0,255, lifespan*3);
    ellipse(position.x, position.y, random(3), random(8));
    
    
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