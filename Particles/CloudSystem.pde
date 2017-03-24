// A class to describe a group of Clouds
// An ArrayList is used to manage the list of Clouds 

class CloudSystem {
  ArrayList<Cloud> clouds;
  PVector origin;
  CloudSystem() {
    clouds = new ArrayList<Cloud>();
  }
  
  void addCloud() {
    origin = new PVector(int(random(width)), 0, 0);
    clouds.add(new Cloud());
  }
  
  void run() {
    //enhaned for loop
    for (Cloud C : clouds) {
      //shorten "lifespan" after 2/3rds of the screen
      if (C.position.x > width-width/3) {
        C.lifespan -= 2.125;
      }
    }

    for (int i = clouds.size()-1; i >= 0; i--) {
      Cloud p = clouds.get(i);
      p.run();
      if (p.isDead()) {
        clouds.remove(i);
      }
    }
  }
}