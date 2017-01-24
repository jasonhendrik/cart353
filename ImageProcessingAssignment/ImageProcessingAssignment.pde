/// Image Mixer by Jason Hendrik


// create three image arrays
PImage image_A;
PImage image_B;
PImage image_C;

//begin at state one
int myState = 1;

//create pos vars
int x;
int y;

//init imageMixer class 3 times for 3 states
imageMixer State1;  
imageMixer State2;
imageMixer State3;


void setup() {
  size(640, 426);

//load the two images that will be mixed
  image_A = loadImage("BiosphereA.jpg"); 
  image_B = loadImage("BiosphereB.jpg"); 
  image_C = createImage(640, 426, RGB);

//create the 3 state - objects
  State1 = new imageMixer(image_A, image_B);
  State2 = new imageMixer(image_B, image_A);
  State3 = new imageMixer(image_A, image_B);

//initialize a first state
  State1.effect1(0, 0);
}

void draw() {  
  //check what state where in
  stateChange();
  //change our state
  stateCheck();
  //listen to mouse data
  x = mouseX;
  y = mouseY;
}




// Here we check the state var and run the corresponding state
void stateCheck() {
  if (myState == 1) {
   // this is an instance of imageMixer with effect 1
    State1.effect1(x, y);
  }
  if (myState == 2) {
    State2.effect2(x, y);
  }
  if (myState == 3) {
    State3.effect3(x, y);
  }
}

// here is where we change the state var based on KB input
void stateChange() {
  if (keyPressed) {
    if (key == '1') {
      myState =1;
    }
  }
  if (keyPressed) {
    if (key == '2') {
      myState =2;
    }
  }
  if (keyPressed) {
    if (key == '3') {
      myState =3;
    }
  }
  if (keyPressed) {
    if (key == 'P' || key == 'p') {
      //print to file
      save("Image_Mixer_Output");
    }
  }
}


// Here is my Image Mixer Class
// Which calls in my images and preps my Mouse X and Y vars.
class imageMixer
{
  PImage image_A;
  PImage image_B;
  PImage image_C;
  imageMixer(PImage image_A, PImage image_B) {
    this.image_A = image_A;
    this.image_B = image_B;
    image_C = image_B;
  }


  //Effect 1
  void effect1(int x, int y) {
    loadPixels();
    image_C.updatePixels();
    image (image_C, 0, 0);
    setColor();
  }


  //Effect 2
  void effect2(int x, int y) {
    loadPixels();

    image_C.updatePixels();
    image (image_C, 0, 0);
    filter(POSTERIZE, int(map(x, 0, width, 2, 255)));
    copy(image_A, x, y, x, y, x, y, 2*x, 2*y);
  }


  //Effect 3
  void effect3(int x, int y) {
    loadPixels();
    image_C.updatePixels();
    image (image_C, 0, 0);
    blend(image_A, x, y, x, y, 0, 0, width, height, HARD_LIGHT);
  }

  //Mix with A
  void setColor() {
    image_C.pixels[y*width+x] = image_A.pixels[y*width+x];
  }
}