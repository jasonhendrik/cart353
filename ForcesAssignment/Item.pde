// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Item {
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean isEaten;
  float mass;
  color itemColor; 

  Item(float m, float x, float y, color RGBvalue) {
    mass = random(1, m+25);
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    isEaten = false;
    //colors!!!
    itemColor = RGBvalue;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, a.G);
    acceleration.add(f);
  }


  void update() {
    //stop forces if food-item is eaten
    if (isEaten == false) {
      velocity.add(acceleration);
      location.add(velocity);
      acceleration.mult(0);
    }
  }
  void display() {
    stroke(0);
    strokeWeight(1);
    fill(itemColor);
    ellipse(location.x, location.y, mass, mass);
  }
}

