// this class is a sub-class of FIRE
class Smoke extends Fire {

  Smoke(PVector l) {
    //inherit the constructor
    super(l);

    //overwrite some construction vars
    acceleration = new PVector(0, -.15);
    velocity = new PVector(random(-2, 2), -2);
  }

  //overwrite the display method
  void display() {
    fill(lifespan);
    stroke(lifespan);
    ellipse(position.x, position.y-75, lifespan/2, lifespan*2);
  }
}