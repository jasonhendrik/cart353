// A class to describe a group of Comets
// An ArrayList is used to manage the list of Comets 

class CometSystem {
  ArrayList<Comet> comets;
  PVector origin;
  PVector randomPos;

  CometSystem(PVector position) {
    origin = position.copy();
    comets = new ArrayList<Comet>();
  }

  void addComet() {
    randomPos = new PVector(random(width),int(random(height/6)),0);
    comets.add(new Comet(randomPos)  );
  }

  void run() {
    for (int i = comets.size()-1; i >= 0; i--) {
      Comet p = comets.get(i);
      p.run();
      if (p.isDead()) {
        comets.remove(i);
      }
    }
  }
}