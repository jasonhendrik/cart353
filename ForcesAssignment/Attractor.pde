
class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
 
  Attractor() {
    location = new PVector(width/2, height-25);
    mass = startingMass;
    G = 2;
    dragOffset = new PVector(0.0, 0.0);
  }

  PVector attract(Item m) {
    PVector force = PVector.sub(location, m.location);     // Calculate direction of force
    float d = force.mag();                                 // Distance between objects
    d = constrain(d, 10.0, 250.0);                         // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                     // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);        // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction
    return force;
  }

  void display() {
    ellipseMode(CENTER);
  if(health > 0){
    if (dragging) fill (100, 100, 100, 50);
    else if (rollover) fill(80, 100, 100, 50);
    else fill(60, 100, 100, 50);
  } else fill(0,0,0,255); 
    strokeWeight(4);
    ellipse(location.x, location.y, mass, mass);
    
  }

  // The methods below are for mouse interaction
  void clicked(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void hover(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag() {
    //check if not dead!!
    if (dragging && health > 0) {
      
      location.x = mouseX + dragOffset.x;
      location.y = mouseY + dragOffset.y;
   
    }
  }
}

