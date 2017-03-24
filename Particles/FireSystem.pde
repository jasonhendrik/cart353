// A class to describe a group of Fires
// An ArrayList is used to manage the list of Fires 

class FireSystem {
  ArrayList<Fire> flames;
  ArrayList<Smoke> smokeClouds;

  PVector origin;

  FireSystem(PVector position) {
    origin = position.copy();
    flames = new ArrayList<Fire>();
    smokeClouds = new ArrayList<Smoke>();
  }

  void addFire() {
    flames.add(new Fire(origin));
    
  }
  
    void addSmoke() {
    smokeClouds.add(new Smoke (origin));
    
  }

  void run() {
    for (int i = flames.size()-1; i >= 0; i--) {
      Fire p = flames.get(i);
      Smoke b = smokeClouds.get(i);
      p.run();
      b.run();
      if (p.isDead()) {
        flames.remove(i);
        smokeClouds.remove(i);
      }
    }
  }
}