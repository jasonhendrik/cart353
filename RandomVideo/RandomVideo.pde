// import video library
import processing.video.*;

//create movie variable(class item)
Movie video;


//create noise value variables
float noiseval;
float noiseScale=1.0;

//create some more quasi-useful variables
float playHeadLocation;
float videoLength;
float xOff;

//frame count and rate 
int newFrame = 0;
int movFrameRate = 30;

//set sizes for copied and drawn pixels
int blockSizeDrawn = 16;
int pixelAmtCopied = 32;

void setup() {
  size(1280, 720);
  //instantiate video file as new movie object
  video = new Movie(this, "TheFrog.mov");
  //call first frame and pause
  video.play();
  video.jump(0);
  video.pause();

  //set noise Detail
  noiseDetail(2);
}

void draw() {
  //set current frame variable
  playHeadLocation = video.time();
  //get time of video file
  videoLength = video.duration();

  //increment xOFfset
  xOff = xOff + noiseScale;
  //create noise varaiable based on the current frame
  noiseval = noise(playHeadLocation) * width;

  // remapp the noise the integer between 0 and 10
  int reMappedNoise = int(map(noiseval, 0, 1000, 0, 30));

  //position the video
  image(video, 0, 0); 

  //create a random number btween 0 and 1 
  int switcher = int(random(2));
  //use that number as a switcher between two modes
  if   (switcher == 1) {
    //mode A: copy pixels and vary redrawn size according to perlin noise
    video.copy(mouseX, mouseY, pixelAmtCopied, pixelAmtCopied, mouseX-blockSizeDrawn/2, mouseY-blockSizeDrawn/2, blockSizeDrawn*reMappedNoise, blockSizeDrawn*reMappedNoise);
  } else {
    //mode B: vary the copied pixels with perlin noise and draw square
    video.copy(mouseX, mouseY, pixelAmtCopied*reMappedNoise, pixelAmtCopied*reMappedNoise, mouseX-blockSizeDrawn/2, mouseY-blockSizeDrawn/2, blockSizeDrawn, blockSizeDrawn);
  }
}

//mouse click for new frames
void mousePressed() {
  //map mouse x position to time length of video
  int mouseFrame = int(map(mouseX, 0, width, 0, int(videoLength)));
  setFrame(mouseFrame);
}


//COPIED FROM VIDEO FRAMES EXAMPLE
int getFrame() {    
  return ceil(video.time() * 30) - 1;
}

void setFrame(int n) {
  video.play();
  // The duration of a single frame:
  float frameDuration = 30.0 / movFrameRate;

  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 

  // Taking into account border effects:
  float diff = video.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
  video.jump(where);
  video.pause();
}  

void movieEvent(Movie video) {
  video.read();
}

int getLength() {
  return int(video.duration() * movFrameRate);
}  

