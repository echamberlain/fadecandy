import processing.video.*;

int i = 0;
OPC opc;
Capture cam;

void setup() {
  size(80, 65, P3D);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    //cam = new Capture(this, cameras[0]);
    cam = new Capture(this, 80, 60, "PureThermal 1", 30);
    cam.start();     
  }      

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  opc.ledGrid(0, 64, 64, width * 1/2, height * 1/2, width/64, height/64, 0, false);
}

void keyPressed() {
  if (key == 'd') opc.setDithering(false);
  
  if ( key == 's' ) {
    saveFrame("Frame-" + i + ".png");
    i++;
  }
}

void keyReleased() {
  if (key == 'd') opc.setDithering(true);
}  


void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  //scale(-1,1);
  
  background(0);
  image(cam, -80, 3);
}