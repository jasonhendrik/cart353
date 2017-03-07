import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;


int selecWidth = 60;
int selecHeight = 60;


Kinect kinect;
ArrayList <SkeletonData> bodies;

PVector exHead = new PVector(0, 0);
PVector exSpine = new PVector(0, 0);
PVector exHipCenter = new PVector(0, 0);
PVector exAnkleRight = new PVector(0, 0);
PVector exAnkleLeft = new PVector(0, 0);
PVector exHandRight = new PVector(0, 0);
PVector exHandLeft = new PVector(0, 0);

PImage exHeadImage = createImage(selecWidth, selecHeight, RGB);
PImage exSpineImage = createImage(selecWidth, selecHeight, RGB);
PImage exHipCenterImage = createImage(selecWidth, selecHeight, RGB);
PImage exAnkleRightImage = createImage(selecWidth, selecHeight, RGB);
PImage exAnkleLeftImage = createImage(selecWidth, selecHeight, RGB);
PImage exHandRightImage = createImage(selecWidth, selecHeight, RGB);
PImage exHandLeftImage = createImage(selecWidth, selecHeight, RGB);


void setup()
{
  size(640, 480);
  background(255);
  kinect = new Kinect(this);
  //smooth();
  bodies = new ArrayList<SkeletonData>();
}

void draw()
{
  background(255);
  // image(kinect.GetImage(), 700, 0, 320, 240);
  // image(kinect.GetDepth(), 700, 240, 320, 240);
  image(kinect.GetMask(), 0, 0, 640, 480);
  for (int i=0; i<bodies.size (); i++) 
  {
    getPartsPositions(bodies.get(i));
    drawPosition(bodies.get(i));
  }


  //call to make a part function
  makeExquisitePart(exHead, exHeadImage);
  makeExquisitePart(exSpine, exSpineImage);
  makeExquisitePart(exHipCenter, exHipCenterImage);
  makeExquisitePart(exAnkleRight, exAnkleRightImage);
  makeExquisitePart(exAnkleLeft, exAnkleLeftImage);
  makeExquisitePart(exHandRight, exHandRightImage);

  println(exHandRight);


  if (exHandRight.y > .8) {
    savePartsImages();
  }
}

//make a image part function
void makeExquisitePart(PVector partPostion, PImage partImage) {

  partImage = kinect.GetMask().get(int(map(partPostion.x, 0, 1, 0, 640))-50, int(map(partPostion.y, 0, 1, 0, 640))-75, 100, 150);
  //track to a spine image for display
  image(partImage, int(map(partPostion.x, 0, 1, 0, 640))-50, int(map(partPostion.y, 0, 1, 0, 640))-75, 100, 150);
}

void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}


void getPartsPositions(SkeletonData _s) 
{


  // here we get our skel-points positions

  exHead = new PVector(_s.skeletonPositions[3].x, _s.skeletonPositions[3].y);
  exSpine = new PVector(_s.skeletonPositions[1].x, _s.skeletonPositions[1].y);
  exHipCenter = new PVector(_s.skeletonPositions[0].x, _s.skeletonPositions[0].y);
  exAnkleRight = new PVector(_s.skeletonPositions[18].x, _s.skeletonPositions[18].y);
  exAnkleLeft = new PVector(_s.skeletonPositions[14].x, _s.skeletonPositions[14].y);
  exHandRight = new PVector(_s.skeletonPositions[11].x, _s.skeletonPositions[11].y);
  exHandLeft = new PVector(_s.skeletonPositions[7].x, _s.skeletonPositions[7].y);
}


void savePartsImages() {

  exHeadImage = kinect.GetMask().get(int(map(exHead.x, 0, 1, 0, 640))-50, int(map(exHead.y, 0, 1, 0, 640))-75, 100, 150);
  exHeadImage.save("heads/Head.jpg");

  exSpineImage = kinect.GetMask().get(int(map(exSpine.x, 0, 1, 0, 640))-50, int(map(exSpine.y, 0, 1, 0, 640))-75, 100, 150);
  exSpineImage.save("spines/Spine.jpg");

  exHipCenterImage = kinect.GetMask().get(int(map(exHipCenter.x, 0, 1, 0, 640))-50, int(map(exHipCenter.y, 0, 1, 0, 640))-75, 100, 150);
  exHipCenterImage.save("hips/Hip.jpg");

  exAnkleRightImage.save("anklesR/AnkleR.jpg");
  exAnkleLeftImage.save("anklesL/AnkelL.jpg");
 
  exHandRightImage.save("handsR/HandR.jpg");
  exHandLeftImage.save("handsL/HandL.jpg");
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
