// A simple Particle class

class Cloud {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Cloud() {
    velocity = new PVector(0, 0);
    position = new PVector(-random(width),random(0,height/5),0);
    lifespan = 64.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    
    acceleration = new PVector(random(.0005,.15), random(-.024,.024),random(-.02,.02));


    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= .125;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, lifespan*1.65, lifespan*1.65);
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