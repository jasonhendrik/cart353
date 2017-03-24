// A class to describe a group of Rains
// An ArrayList is used to manage the list of Rains 

class RainSystem {
  ArrayList<Rain> raindrops;
   PVector origin = new PVector(0,0,0);

  RainSystem() {
    raindrops = new ArrayList<Rain>();
    
  }

  void addRain() {
    origin.x = random(width);
    raindrops.add(new Rain(origin));
 
  }

  void run() {
    for (int i = raindrops.size()-1; i >= 0; i--) {
      Rain p = raindrops.get(i);
      p.run();
      if (p.isDead()) {
        raindrops.remove(i);
      }
    }
  }
}