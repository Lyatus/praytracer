import java.util.concurrent.Semaphore;

int threadCount = Runtime.getRuntime().availableProcessors();
Semaphore startSem = new Semaphore(0);
Semaphore endSem = new Semaphore(0);
Camera camera;
World world;

void setup() {
  size(16*32, 9*32);
  frameRate(9999); // Gotta go fast!
  println("Initializing world");
  world = new World();
  camera = new Camera(new PVector(5, 4, 5), new PVector(0, 1, 0), (float)width/height);
  Material defaultMaterial = new Material(#FFFFFF, 0);
  Material redMaterial = new Material(#FF0000, .5);
  world.add(new Plane(defaultMaterial, new PVector(0, 0, 0), new PVector(0, 1, 0)));
  world.add(new Disc(redMaterial, new PVector(0, 3, 0), new PVector(.1, .5, 1), 2));
  world.add(new Sphere(defaultMaterial, new PVector(0, 2, 0), 1));
  world.add(new Sphere(redMaterial, new PVector(2, 0, 0), 1));
  world.add(new Cube(defaultMaterial, new PVector(0, 0, 2), 1));
  //world.add(new DirectionalLight(new PVector(1, 1, 1)));
  world.add(new PointLight(new PVector(2, 5, 2), 10));
  //world.add(new PointLight(new PVector(2, 2, -4), 6));
  //world.add(new SpotLight(new PVector(10, 10, 10), new PVector(-1, -1, -1), 32, .01));
  println("Initializing "+threadCount+" render threads");
  for (int i=0; i<threadCount; i++)
    new RenderThread(i).start();
}

int lastms = 0;
void draw() {
  int currentms = millis();
  float rmouseX = (pmouseX-mouseX)*(float)(currentms-lastms)/1000, rmouseY = (pmouseY-mouseY)*(float)(currentms-lastms)/1000;
  camera.rotateAround(rmouseX); // Rotate camera
  lastms = currentms;
  try {
    startSem.release(threadCount); // Start all thread
    endSem.acquire(threadCount); // Wait for all to end
  }
  catch(InterruptedException ie) {
    println("Something went wrong");
  }
  if (frameCount%32==1) {
    println("FPS: "+frameRate);
    float frameDuration = (1/frameRate)*1000;
    println("Frame duration: "+frameDuration+" milliseconds");
    float pixelDuration = (frameDuration / (width*height))*1000;
    println("Pixel processing duration: "+pixelDuration+" microseconds");
  }
}

