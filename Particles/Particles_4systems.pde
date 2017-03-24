PVector mouseInput = new PVector(0, 0, 0);

int numBlocks = 990;
int blockDepth = 190;
int zFix = numBlocks;


int offSet = 110;

//adding all particle systems
RainSystem rain;
CloudSystem clouds;
CometSystem comets;
FireSystem flames;

void setup() {
  size(900, 900, P3D);
  noStroke();
  lights();

  //initialize the particle systems and give them positions if needed.
  rain = new RainSystem();
  clouds = new CloudSystem();
  comets = new CometSystem(new PVector(width/2, 25));
  flames = new FireSystem(new PVector(width/2, height));
}

void draw() {
  //set BG to black
  background(0, 0, 0);

  //add clouds at random position by mouse drag
  clouds.run();


  //add rain particles
  rain.addRain();
  rain.run();

  //add comets at random position by mouse click
  comets.run();

  //add fire particles
  flames.addFire();
  flames.addSmoke();
  flames.run();
}


void mousePressed() {
  comets.addComet();
}

void mouseDragged() 
{
  clouds.addCloud();
}