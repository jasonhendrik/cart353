class Sensor {

  int locationX;
  int locationY;
  boolean Xstate;
  boolean Ystate;
  boolean sensing = false;
  int scaleXY;
  int sensorRange;

  Sensor(int locX, int locY, int size, int Range) {
    scaleXY = size;
    locationX = locX;
    locationY = locY;
    sensorRange = Range;
  }

  void display() {
    if (sensing == false) {
      stroke(255);
      noFill();
      ellipseMode(CORNER);
      ellipse(locationX, locationY, scaleXY, scaleXY);
    } else {
    }
  }

  boolean sensing(PVector input) {

    display();

    sensing = false;

    if (abs(input.x - locationX-scaleXY/2) <= sensorRange) {
      Xstate = true;
    } else {
      Xstate = false;
    }


    if (abs(input.y - locationY-scaleXY/2) <= sensorRange) {
      Ystate = true;
    } else {
      Ystate = false;
    }

    if (Xstate == true && Ystate == true) {
      sensing = true;
    }
    return sensing;
  }
}