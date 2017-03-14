//call to libraries
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

//set width and height for "parts"
int selecWidth = 90;
int selecHeight = 90;

int imgNum = 0;

//initialize kinect input
Kinect kinect;
//create array of skeleton position data
ArrayList <SkeletonData> bodies;

//create my positions for tracking "parts"
PVector exHead = new PVector(0, 0);
PVector exSpine = new PVector(0, 0);
PVector exHipCenter = new PVector(0, 0);
PVector exAnkleRight = new PVector(0, 0);
PVector exAnkleLeft = new PVector(0, 0);
PVector exHandRight = new PVector(0, 0);
PVector exHandLeft = new PVector(0, 0);

//create my images of "parts"
PImage exHeadImage = createImage(selecWidth, selecHeight, RGB);
PImage exSpineImage = createImage(selecWidth, selecHeight, RGB);
PImage exHipCenterImage = createImage(selecWidth, selecHeight, RGB);
PImage exAnkleRightImage = createImage(selecWidth, selecHeight, RGB);
PImage exAnkleLeftImage = createImage(selecWidth, selecHeight, RGB);
PImage exHandRightImage = createImage(selecWidth, selecHeight, RGB);
PImage exHandLeftImage = createImage(selecWidth, selecHeight, RGB);

boolean pictureTaken = false;



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
}






// BEGIN MAIN PROGRAM
void draw()
{
  //set BG color
  background(0);
  //display + position kinect RGB mask image
  image(kinect.GetMask(), 0, 0, 640, 480);

  // get positions for all bodies (not unlimited)
  for (int i=0; i<bodies.size (); i++) 
  {
    //transfer PVectors to my "parts"
    getPartsPositions(bodies.get(i));
    //
    // drawPosition(bodies.get(i));
  }


  //call to make-part function
  makeExquisitePart(exHead, exHeadImage);
  makeExquisitePart(exSpine, exSpineImage);
  makeExquisitePart(exHipCenter, exHipCenterImage);
  makeExquisitePart(exAnkleRight, exAnkleRightImage);
  makeExquisitePart(exAnkleLeft, exAnkleLeftImage);
  makeExquisitePart(exHandRight, exHandRightImage);
  makeExquisitePart(exHandLeft, exHandLeftImage);


  // if both hands are "way" up - take pictures of parts
  // println(exHandRight.y + " " + exHandLeft.y);
  if (exHandRight.y < .1 && exHandLeft.y <.1) {
    if (exHandRight.y > 0 && exHandLeft.y > 0) {
      imgNum += 1;
      savePartsImages(imgNum);
      pictureTaken = true;
    }
    
    //trigger random numbers of range "amount of photos"
    //send to iamge selection process
    
    
  }

  //println(pictureTaken); 
  if (pictureTaken == true) {

    randomCorpse();
  }
  
  println(exHead.z);
}


//END MAIN PROGRAM





//make a image part function
void makeExquisitePart(PVector partPosition, PImage newPartImage) {

  newPartImage = kinect.GetMask().get(int(map(partPosition.x, 0, 1, 0, 640))-50, int(map(partPosition.y, 0, 1, 0, 640))-75, selecWidth, selecHeight);
  //track to a spine image for display
  image(newPartImage, int(map(partPosition.x, 0, 1, 0, 640))-50, int(map(partPosition.y, 0, 1, 0, 640))-75, selecWidth, selecHeight);
}


void getPartsPositions(SkeletonData _s) 
{


  // here we get our skel-points positions

  exHead = new PVector(_s.skeletonPositions[3].x, _s.skeletonPositions[3].y,_s.skeletonPositions[3].z);
  exSpine = new PVector(_s.skeletonPositions[1].x, _s.skeletonPositions[1].y);
  exHipCenter = new PVector(_s.skeletonPositions[0].x, _s.skeletonPositions[0].y);
  exAnkleRight = new PVector(_s.skeletonPositions[18].x, _s.skeletonPositions[18].y);
  exAnkleLeft = new PVector(_s.skeletonPositions[14].x, _s.skeletonPositions[14].y);
  exHandRight = new PVector(_s.skeletonPositions[11].x, _s.skeletonPositions[11].y);
  exHandLeft = new PVector(_s.skeletonPositions[7].x, _s.skeletonPositions[7].y);
}


void savePartsImages(int imgNum) {
  
  
  
  exHeadImage = kinect.GetMask().get(int(map(exHead.x, 0, 1, 0, 640))-50, int(map(exHead.y, 0, 1, 0, 640))-75, 100, 150);
  exHeadImage.save("/heads/" + imgNum + "_Head.png");

  exSpineImage = kinect.GetMask().get(int(map(exSpine.x, 0, 1, 0, 640))-50, int(map(exSpine.y, 0, 1, 0, 640))-75, 100, 150);
  exSpineImage.save("/spines/" + imgNum + "_Spine.png");

  exHipCenterImage = kinect.GetMask().get(int(map(exHipCenter.x, 0, 1, 0, 640))-50, int(map(exHipCenter.y, 0, 1, 0, 640))-75, 100, 150);
  exHipCenterImage.save("/hips/" +imgNum + "_Hip.png");

  exHandRightImage = kinect.GetMask().get(int(map(exHandRight.x, 0, 1, 0, 640))-50, int(map(exHandRight.y, 0, 1, 0, 640))-75, 100, 150);
  exHandRightImage.save("/handsR/" + imgNum + "_HandR.png");

  exHandLeftImage = kinect.GetMask().get(int(map(exHandLeft.x, 0, 1, 0, 640))-50, int(map(exHandLeft.y, 0, 1, 0, 640))-75, 100, 150);
  exHandLeftImage.save("/handsL/" +imgNum + "_HandL.png");

  exAnkleRightImage = kinect.GetMask().get(int(map(exAnkleRight.x, 0, 1, 0, 640))-50, int(map(exAnkleRight.y, 0, 1, 0, 640))-75, 100, 150);
  exAnkleRightImage.save("/AnkelR/" + imgNum + "_AnkelR.png");

  exAnkleLeftImage = kinect.GetMask().get(int(map(exAnkleLeft.x, 0, 1, 0, 640))-50, int(map(exAnkleLeft.y, 0, 1, 0, 640))-75, 100, 150);
  exAnkleLeftImage.save("/AnkelL/" + imgNum + "_AnkelL.png");
}



// draw a random corpse pinned to user

void randomCorpse() {
 PImage randomHead = loadImage("/heads/" + imgNum + "_Head.png");
 
 //and scale by z
 
 image(randomHead, int(map(exHead.x, 0, 1, 0, 640))-50, int(map(exHead.y, 0, 1, 0, 640))-75, selecWidth * int(map(exHead.z,17000,8000,1,3)), selecHeight * int(map(exHead.z,17000,8000,1,3)));
 
 PImage randomSpine = loadImage("/spines/" + imgNum + "_Spine.png");
 image(randomSpine, int(map(exSpine.x, 0, 1, 0, 640))-50, int(map(exSpine.y, 0, 1, 0, 640))-75,selecWidth,selecHeight);
 
 PImage randomHip = loadImage("/hips/" + imgNum + "_Hip.png");
 image(randomHip, int(map(exHipCenter.x, 0, 1, 0, 640))-50, int(map(exHipCenter.y, 0, 1, 0, 640))-75, selecWidth * int(map(exHipCenter.z,17000,8000,1,3)), selecHeight * int(map(exHipCenter.z,17000,8000,1,3)));
 
 PImage randomhandR = loadImage("/handsR/" + imgNum + "_HandR.png");
 image(randomhandR, int(map(exHandRight.x, 0, 1, 0, 640))-50, int(map(exHandRight.y, 0, 1, 0, 640))-75,selecWidth,selecHeight);
 
 PImage randomHandL = loadImage("/handsL/" + imgNum + "_HandL.png");
 image(randomHandL, int(map(exHandLeft.x, 0, 1, 0, 640))-50, int(map(exHandLeft.y, 0, 1, 0, 640))-75,selecWidth,selecHeight);


}




void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width/2, 
      _s.skeletonPositions[_j1].y*height/2, 
      _s.skeletonPositions[_j2].x*width/2, 
      _s.skeletonPositions[_j2].y*height/2);
  }
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
