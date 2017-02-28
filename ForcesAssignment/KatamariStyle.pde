//Interactions based on

//Largely Based off examples provided in "The Nature of Code"

//set the amount of "items" or "food" as well as the max-size (also mass)
int NumAndSizeRange = 50;

//set initial mass of Attractor
int startingMass = 10;
float prevMass = startingMass;

//for shake (roll) effect
boolean shaking = false;
int shakeAmount = 0;
int shakeValue;

//set shake range
int shakeMin = 25;
int shakeMax = 150;


//set initial health
float health = 100;
float MAX_HEALTH = 100;
//set width of GUI health object
float rectWidth = 200;

//create array of food-items
Item[] items = new Item[NumAndSizeRange];

//declare user-attractor variable
Attractor a;

//init force vector
PVector force;

void setup() { 
  frameRate(30);
  //change color mode to Hue,Saturation,Brightness
  colorMode(HSB, 100, 100, 100);
  size(1280, 720);

  //cycle through all food-items, give them mass(size), position and color
  for (int i = 0; i < items.length; i++) {
    // keep them away from bottom 75 pixels
    items[i] = new Item(NumAndSizeRange, random(width), random(height-75), color(random(100), 100, 100, 90));
  }

  //initialize user-attractor varaible 
  a = new Attractor();
}

void draw() {

  //set bg color
  background(15, 60, 100, 255);

  //cycle through all food-items
  for (int i = 0; i < items.length; i++) { 
    //find distance between attractor and food-items
    float distance = PVector.dist(a.location, items[i].location);
    //set force
    force = a.attract(items[i]);

    //check if attractor is larger than food-item
    if (a.mass >= items[i].mass) {
      //check if distance is less than food-item's mass 
      if (distance < items[i].mass) {
        //set location of food-items to attractor's positions
        items[i].location = a.location; 
        // check if food-item is not eaten
        if (items[i].isEaten == false) {
          //increase attractor mass based on what it eats
          a.mass = a.mass + items[i].mass/6;
          //set previous mass variable, for shake (roll) effect
          prevMass = a.mass;
          //change food-item's state to eaten
          items[i].isEaten = true;
          //increase gravitational constant of attractor
          a.G = a.G + 1/items[i].mass;
        }
      }
      //check if collided with larger food-item
    } else if (distance < items[i].mass - distance) 
    {
      //flash black to BG
      background(0, 0, 0, 0);
      //decrease health points
      if (health <= 0) {
        health = 0;
      } else
        //decrement
      health -= 2;
    }

    //apply gravitational force based on proximity
    if (distance < items[i].mass * a.G) 
    {
      items[i].applyForce(force);
    }
    //update food-items 
    items[i].update();
    //display food-items
    items[i].display();
  }


  //check if attractor DEAD - GAME OVER
  if (health == 0) {
    //uneat all the items
    for (int i = 0; i < items.length; i++) {
      //free eaten food-items
      items[i].isEaten = false;

      //kill grav constant
      a.G = 0;
      //hardcode position to CENTER
      a.location.x = width/2;
      a.location.y = height/2;
    }
  }

  //increase the attractor's mass and gravitational force when mouse is "SHAKING"
  if (shaking == true) {
    a.mass+=3;
    a.G++;
  } 
  //decrease the attractor's mass and gravitational force when mouse is "NOT SHAKING"
  if (shaking == false) {
    if (a.mass > prevMass) {
      a.mass-=1;
    }
  }
  //display the attractor
  a.display();
  //utilize dragging funcionality
  a.drag();
  //utilize hover
  a.hover(mouseX, mouseY);
  // display health bar
  drawHealth();
  //changes "shaking" state based on mouse movement
  isMouseShaking();
}


void mousePressed() {
  a.clicked(mouseX, mouseY);
}

void mouseReleased() {
  a.stopDragging();
}

//check if mouse is "SHAKING"
void isMouseShaking() {
  //get absolute value of diff. between current mouse pos and prev mouse pos
  shakeValue = abs(mouseX - pmouseX);
  //check if shakeValue is within shake range
  if (shakeValue > shakeMin && shakeValue < shakeMax) {
    //set shake state
    shaking = true;
    //increase shake amount
    shakeAmount ++;
  } else
    //set shake state
  shaking = false;
  //reset shake Amount
  shakeAmount = 0;
}


//health bar code reference: "https://www.openprocessing.org/sketch/120612" by Devon Scott-Tunkin
void drawHealth() {
  // Change color mode
  colorMode(RGB);
  if (health < 25)
  {
    fill(255, 0, 0);
  } else if (health < 50)
  {
    fill(255, 200, 0);
  } else
  {
    fill(0, 255, 0);
  }
  // Draw bar
  noStroke();
  // Get fraction 0->1 and multiply it by width of bar
  float drawWidth = (health / MAX_HEALTH) * rectWidth;
  rect(82, 20, drawWidth, 25);
  // Outline
  stroke(0);
  strokeWeight(2);
  noFill();
  rect(82, 20, rectWidth, 25);
  //switch color mode back
  colorMode(HSB);
  fill(100, 0, 0, 255);
  textSize(16);
  text("HEALTH", 15, 40);
  // end borrowed code
}

