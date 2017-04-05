//call to libraries
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
//initialize kinect input
Kinect kinect;
//create array of skeleton position data
ArrayList <SkeletonData> bodies;


//set width and height for "parts"
int selecWidth = 80;
int selecHeight = 80;
//number the images
int imgNum = 0;
//set picture taken state
boolean pictureTaken = false;




//create my images of "parts"
PImage  exHeadImage, exKneeLeftImage, exFootRightImage, exFootLeftImage, exElbowRightImage, exElbowLeftImage, exShoulderRightImage, exShoulderLeftImage = createImage(selecWidth, selecHeight, RGB);
PImage  exShoulderCenterImage, exSpineImage, exHipCenterImage, exAnkleRightImage, exAnkleLeftImage, exHandRightImage, exHandLeftImage, exKneeRightImage = createImage(selecWidth, selecHeight, RGB);


//create my positions for tracking "parts"
PVector exHead = new PVector(0, 0, 0);
PVector exShoulderCenter = new PVector(0, 0, 0);
PVector exSpine = new PVector(0, 0, 0);
PVector exHipCenter = new PVector(0, 0, 0);
PVector exAnkleRight = new PVector(0, 0, 0);
PVector exAnkleLeft = new PVector(0, 0, 0);
PVector exHandRight = new PVector(0, 0, 0);
PVector exHandLeft = new PVector(0, 0, 0);
PVector exKneeRight = new PVector(0, 0, 0);
PVector exFootRight = new PVector(0, 0, 0);
PVector exKneeLeft = new PVector(0, 0, 0);
PVector exFootLeft = new PVector(0, 0, 0);
PVector exElbowRight = new PVector(0, 0, 0);
PVector exElbowLeft = new PVector(0, 0, 0);
PVector exShoulderRight = new PVector(0, 0, 0);
PVector exShoulderLeft = new PVector(0, 0, 0);


//For Z depth/ size
int depth = 60;
int initRange = 12000;

int timer;
int interval = 10000;

int rHead, rShRight, rShLeft, rERight, rELeft, rKnRight, rKnLeft, rFLeft, rFRight, rSpine, rHipCenter, rHright, rHleft, rAright, rAleft;

void setup()
{
  //set screen size
  size(640, 480);
  //create kinect object
  kinect = new Kinect(this);
  //antiAliasing
  smooth();
  //create bodies (of position data)
  bodies = new ArrayList<SkeletonData>();
  background(0);
}


// BEGIN MAIN PROGRAM
void draw()
{
  //set BG color
  background(0);
  //display + position kinect RGB mask image
  //image(kinect.GetMask(), 0, 0, 640, 480);

  // get positions for all bodies (not unlimited)
  for (int i=0; i<bodies.size (); i++) 
  {
    //transfer PVectors to my "parts"
    getPartsPositions(bodies.get(i));

    //call to make-part function
    makeExquisitePart(exHead, exHeadImage); 
    makeExquisitePart(exSpine, exSpineImage);
    makeExquisitePart(exHipCenter, exHipCenterImage);
    makeExquisitePart(exElbowRight, exElbowRightImage);
    makeExquisitePart(exElbowLeft, exElbowLeftImage);
    makeExquisitePart(exShoulderRight, exShoulderRightImage);
    makeExquisitePart(exShoulderLeft, exShoulderLeftImage);
    makeExquisitePart(exFootRight, exFootRightImage);
    makeExquisitePart(exFootLeft, exFootLeftImage);
    makeExquisitePart(exKneeLeft, exKneeLeftImage);
    makeExquisitePart(exKneeRight, exKneeRightImage);
    makeExquisitePart(exAnkleRight, exAnkleRightImage);
    makeExquisitePart(exAnkleLeft, exAnkleLeftImage);
    makeExquisitePart(exHandRight, exHandRightImage);
    makeExquisitePart(exHandLeft, exHandLeftImage);
  }

  //take a picture and randomize every "X" seconds
  if (bodies.size() > 0 && millis() - timer >= interval) {

    savePartsImages(imgNum);
    imgNum += 1;

    rHead = int(random(1, imgNum));
    rShRight = int(random(1, imgNum)); 
    rShLeft= int(random(1, imgNum));
    rERight= int(random(1, imgNum));
    rELeft= int(random(1, imgNum));
    rKnRight= int(random(1, imgNum));
    rKnLeft= int(random(1, imgNum));
    rFLeft= int(random(1, imgNum));
    rFRight= int(random(1, imgNum));
    rSpine = int(random(1, imgNum)); 
    rHipCenter = int(random(1, imgNum)); 
    rHright = int(random(1, imgNum)); 
    rHleft = int(random(1, imgNum)); 
    rAright = int(random(1, imgNum)); 
    rAleft = int(random(1, imgNum));

    //println(rHead, rShRight, rShLeft, rERight, rELeft, rKnRight, rKnLeft, rFLeft, rFRight, rSpine, rHipCenter, rHright, rHleft, rAright, rAleft);
    timer = millis();
  }
  println(bodies.size() );
  if (bodies.size() > 0 && timer > interval+1000) {
    //make a corpse with new random parts
    randomCorpse(rHead, rShRight, rShLeft, rERight, rELeft, rKnRight, rKnLeft, rFLeft, rFRight, rSpine, rHipCenter, rHright, rHleft, rAright, rAleft);
  }


  exquisiteInterface();
}

//INTERFACE && INFO
void exquisiteInterface() {
  text("Exquisite Corpse Beta 0.01 - JASONHENDRIK 2017\nTake pictures every 10 seconds, randomize from parts is ON", 20, height-36);
}



//Returns our positions for individual parts.
void getPartsPositions(SkeletonData _s) 
{  
  exHead = new PVector(map(_s.skeletonPositions[3].x, 0, 1, 0, width), map(_s.skeletonPositions[3].y, 0, 1, 0, height), -map(_s.skeletonPositions[3].z, 0, initRange, -depth, 0));
  exShoulderCenter = new PVector(map(_s.skeletonPositions[2].x, 0, 1, 0, width), map(_s.skeletonPositions[2].y, 0, 1, 0, height), -map(_s.skeletonPositions[2].z, 0, initRange, -depth, 0));
  exSpine = new PVector(map(_s.skeletonPositions[1].x, 0, 1, 0, width), map(_s.skeletonPositions[1].y, 0, 1, 0, height), map(_s.skeletonPositions[1].z, 0, initRange, -depth, 0));
  exHipCenter = new PVector(map(_s.skeletonPositions[0].x, 0, 1, 0, width), map(_s.skeletonPositions[0].y, 0, 1, 0, height), map(_s.skeletonPositions[0].z, 0, initRange, -depth, 0));

  exAnkleRight = new PVector(map(_s.skeletonPositions[18].x, 0, 1, 0, width), map(_s.skeletonPositions[18].y, 0, 1, 0, height), map(_s.skeletonPositions[18].z, 0, initRange, -depth, 0));
  exAnkleLeft = new PVector(map(_s.skeletonPositions[14].x, 0, 1, 0, width), map(_s.skeletonPositions[14].y, 0, 1, 0, height), map(_s.skeletonPositions[14].z, 0, initRange, -depth, 0));

  exKneeRight = new PVector(map(_s.skeletonPositions[17].x, 0, 1, 0, width), map(_s.skeletonPositions[17].y, 0, 1, 0, height), map(_s.skeletonPositions[17].z, 0, initRange, -depth, 0));
  exKneeLeft = new PVector(map(_s.skeletonPositions[13].x, 0, 1, 0, width), map(_s.skeletonPositions[13].y, 0, 1, 0, height), map(_s.skeletonPositions[13].z, 0, initRange, -depth, 0));

  exFootRight = new PVector(map(_s.skeletonPositions[19].x, 0, 1, 0, width), map(_s.skeletonPositions[19].y, 0, 1, 0, height), map(_s.skeletonPositions[19].z, 0, initRange, -depth, 0));
  exFootLeft = new PVector(map(_s.skeletonPositions[15].x, 0, 1, 0, width), map(_s.skeletonPositions[15].y, 0, 1, 0, height), map(_s.skeletonPositions[15].z, 0, initRange, -depth, 0));

  exElbowRight = new PVector(map(_s.skeletonPositions[9].x, 0, 1, 0, width), map(_s.skeletonPositions[9].y, 0, 1, 0, height), map(_s.skeletonPositions[9].z, 0, initRange, -depth, 0));
  exElbowLeft = new PVector(map(_s.skeletonPositions[5].x, 0, 1, 0, width), map(_s.skeletonPositions[5].y, 0, 1, 0, height), map(_s.skeletonPositions[5].z, 0, initRange, -depth, 0));

  exHandRight = new PVector(map(_s.skeletonPositions[11].x, 0, 1, 0, width), map(_s.skeletonPositions[11].y, 0, 1, 0, height), map(_s.skeletonPositions[11].z, 0, initRange, -depth, 0));
  exHandLeft = new PVector(map(_s.skeletonPositions[7].x, 0, 1, 0, width), map(_s.skeletonPositions[7].y, 0, 1, 0, height), map(_s.skeletonPositions[7].z, 0, initRange, -depth, 0));

  exShoulderRight = new PVector(map(_s.skeletonPositions[8].x, 0, 1, 0, width), map(_s.skeletonPositions[8].y, 0, 1, 0, height), map(_s.skeletonPositions[8].z, 0, initRange, -depth, 0));
  exShoulderLeft = new PVector(map(_s.skeletonPositions[4].x, 0, 1, 0, width), map(_s.skeletonPositions[4].y, 0, 1, 0, height), map(_s.skeletonPositions[4].z, 0, initRange, -depth, 0));
}

//Create a "part" -Requires position and image variables.
void makeExquisitePart(PVector partPosition, PImage newPartImage) {
  imageMode(CENTER);
  newPartImage = kinect.GetMask().get(int(map(partPosition.x, 0, 1, 0, width))-selecWidth/2, int(map(partPosition.y, 0, 1, 0, height))-selecHeight/2, selecWidth, selecHeight);
  image(newPartImage, int(map(partPosition.x, 0, 1, 0, 640))-selecWidth/2, int(map(partPosition.y, 0, 1, 0, 640))-selecHeight/2, selecWidth, selecHeight);
  imageMode(CORNER);
}


void savePartsImages(int imgNum) { 


  exHeadImage = kinect.GetMask().get(int(exHead.x-selecWidth/2), int(exHead.y-selecHeight/2), selecWidth, selecHeight);
  exHeadImage.save("/heads/" + imgNum + "_Head.png");

  exKneeLeftImage = kinect.GetMask().get(int(exKneeLeft.x-selecWidth/2), int(exKneeLeft.y-selecHeight/2), selecWidth, selecHeight);
  exKneeLeftImage.save("/knLeft/" + imgNum + "_KnLeft.png");

  exKneeRightImage = kinect.GetMask().get(int(exKneeRight.x-selecWidth/2), int(exKneeRight.y-selecHeight/2), selecWidth, selecHeight);
  exKneeRightImage.save("/knRight/" + imgNum + "_KnRight.png");

  exFootRightImage = kinect.GetMask().get(int(exFootRight.x-selecWidth/2), int(exFootRight.y-selecHeight/2), selecWidth, selecHeight);
  exFootRightImage.save("/fRight/" + imgNum + "_FRight.png");

  exFootLeftImage = kinect.GetMask().get(int(exFootLeft.x-selecWidth/2), int(exFootLeft.y-selecHeight/2), selecWidth, selecHeight);
  exFootLeftImage.save("/fLeft/" + imgNum + "_FLeft.png");

  exShoulderRightImage = kinect.GetMask().get(int(exShoulderRight.x-selecWidth/2), int(exShoulderRight.y-selecHeight/2), selecWidth, selecHeight);
  exShoulderRightImage.save("/shRight/" + imgNum + "_ShRight.png");

  exShoulderLeftImage = kinect.GetMask().get(int(exShoulderLeft.x-selecWidth/2), int(exShoulderLeft.y-selecHeight/2), selecWidth, selecHeight);
  exShoulderLeftImage.save("/shLeft/" + imgNum + "_ShLeft.png");

  exSpineImage = kinect.GetMask().get(int(exSpine.x-selecWidth/2), int(exSpine.y-selecHeight/2), selecWidth, selecHeight);
  exSpineImage.save("/spines/" + imgNum + "_Spine.png");

  exHipCenterImage = kinect.GetMask().get(int(exHipCenter.x-selecWidth/2), int(exHipCenter.y-selecHeight/2), selecWidth, selecHeight);
  exHipCenterImage.save("/hips/" +imgNum + "_Hip.png");

  exElbowLeftImage = kinect.GetMask().get(int(exElbowLeft.x-selecWidth/2), int(exElbowLeft.y-selecHeight/2), selecWidth, selecHeight);
  exElbowLeftImage.save("/eLeft/" + imgNum + "_ELeft.png");

  exElbowRightImage = kinect.GetMask().get(int(exElbowRight.x-selecWidth/2), int(exElbowRight.y-selecHeight/2), selecWidth, selecHeight);
  exElbowRightImage.save("/eRight/" + imgNum + "_ERight.png");

  exHandRightImage = kinect.GetMask().get(int(exHandRight.x-selecWidth/2), int(exHandRight.y-selecHeight/2), selecWidth, selecHeight);
  exHandRightImage.save("/handsR/" + imgNum + "_HandR.png");

  exHandLeftImage = kinect.GetMask().get(int(exHandLeft.x-selecWidth/2), int(exHandLeft.y-selecHeight/2), selecWidth, selecHeight);
  exHandLeftImage.save("/handsL/" +imgNum + "_HandL.png");

  exAnkleRightImage = kinect.GetMask().get(int(exAnkleRight.x-selecWidth/2), int(exAnkleRight.y-selecHeight/2), selecWidth, selecHeight);
  exAnkleRightImage.save("/anklesR/" + imgNum + "_AnkleR.png");

  exAnkleLeftImage = kinect.GetMask().get(int(exAnkleLeft.x-selecWidth/2), int(exAnkleLeft.y-selecHeight/2), selecWidth, selecHeight);
  exAnkleLeftImage.save("/anklesL/" + imgNum + "_AnkleL.png");
}




// draw a random corpse pinned to user 
void randomCorpse(int rHead, int rShRight, int  rShLeft, int  rERight, int  rELeft, int  rKnRight, int  rKnLeft, int  rFLeft, int rFRight, int rSpine, int rHipCenter, int rHright, int rHleft, int rAright, int rAleft) {

  imageMode(CENTER);
  blendMode(BLEND);
  PImage randomHead = loadImage("/heads/" + rHead + "_Head.png");
  image(randomHead, exHead.x, exHead.y, selecWidth+exHead.z, selecHeight+exHead.z);

  PImage randomShRight = loadImage("/shRight/" + rShRight + "_ShRight.png");
  image(randomShRight, exShoulderRight.x, exShoulderRight.y, selecWidth+exShoulderRight.z, selecHeight+exShoulderRight.z);

  PImage randomShLeft = loadImage("/shLeft/" + rShLeft + "_ShLeft.png");
  image(randomShLeft, exShoulderLeft.x, exShoulderLeft.y, selecWidth+exShoulderLeft.z, selecHeight+exShoulderLeft.z);

  PImage randomERight = loadImage("/eRight/" + rERight + "_ERight.png");
  image(randomERight, exElbowRight.x, exElbowRight.y, selecWidth+exElbowRight.z, selecHeight+exElbowRight.z);

  PImage randomELeft = loadImage("/eLeft/" + rELeft + "_ELeft.png");
  image(randomELeft, exElbowLeft.x, exElbowLeft.y, selecWidth+exElbowLeft.z, selecHeight+exElbowLeft.z);

  PImage randomKnRight = loadImage("/knRight/" + rKnRight + "_KnRight.png");
  image(randomKnRight, exKneeRight.x, exKneeRight.y, selecWidth+exKneeRight.z, selecHeight+exKneeRight.z);

  PImage randomKnLeft = loadImage("/knLeft/" + rKnLeft + "_KnLeft.png");
  image(randomKnLeft, exKneeLeft.x, exKneeLeft.y, selecWidth+exKneeLeft.z, selecHeight+exKneeLeft.z);

  PImage randomFRight = loadImage("/fRight/" + rFRight + "_FRight.png");
  image(randomFRight, exFootRight.x, exFootRight.y, selecWidth+exFootRight.z, selecHeight+exFootRight.z);

  PImage randomFLeft = loadImage("/fLeft/" + rFLeft + "_FLeft.png");
  image(randomFLeft, exFootLeft.x, exFootLeft.y, selecWidth+exFootLeft.z, selecHeight+exFootLeft.z);

  PImage randomSpine = loadImage("/spines/" + rSpine + "_Spine.png");
  image(randomSpine, exSpine.x, exSpine.y, selecWidth+exSpine.z, selecHeight+exSpine.z);

  PImage randomHip = loadImage("/hips/" + rHipCenter + "_Hip.png");
  image(randomHip, exHipCenter.x, exHipCenter.y, selecWidth+exHipCenter.z, selecHeight+exHipCenter.z);

  PImage randomhandR = loadImage("/handsR/" + rHright + "_HandR.png");
  image(randomhandR, exHandRight.x, exHandRight.y, selecWidth+exHandRight.z, selecHeight+exHandRight.z);

  PImage randomHandL = loadImage("/handsL/" + rHleft + "_HandL.png");
  image(randomHandL, exHandLeft.x, exHandLeft.y, selecWidth+exHandLeft.z, selecHeight+exHandLeft.z);

  PImage randomAnkleR = loadImage("/anklesR/" + rAright + "_AnkleR.png");
  image(randomAnkleR, exAnkleRight.x, exAnkleRight.y, selecWidth+exAnkleRight.z, selecHeight+exAnkleRight.z);

  PImage randomAnkleL = loadImage("/anklesL/" + rAleft + "_AnkleL.png");
  image(randomAnkleL, exAnkleLeft.x, exAnkleLeft.y, selecWidth+exAnkleLeft.z, selecHeight+exAnkleLeft.z);





  imageMode(CORNER);
}


void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
