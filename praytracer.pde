import java.util.concurrent.Semaphore;

// Threading globals
int threadCount = Runtime.getRuntime().availableProcessors();
Semaphore startSem = new Semaphore(0);
Semaphore endSem = new Semaphore(0);
RenderThread[] renderThreads = new RenderThread[threadCount];

// Raycasting globals
Camera camera;
World world;

void setup() {
  size(1024, 576);
  frameRate(9999); // Gotta go fast!
  println("Initializing world");
  world = new World();
  camera = new Camera(new PVector(5, 4, 5), new PVector(0, 1, 0), (float)width/height);
  Material defaultMaterial = new Material(#FFFFFF, 0);
  Material redMaterial = new Material(#FF0000, .5);
  Material greenMaterial = new Material(#00FF00, .2);
  Material blueMaterial = new Material(#0000FF, 1);
  world.add(new Plane(defaultMaterial, new PVector(0, 0, 0), new PVector(0, 1, 0)));
  world.add(new Disc(blueMaterial, new PVector(0, 3, 0), new PVector(.1, .5, 1), 2));
  world.add(new Sphere(defaultMaterial, new PVector(0, 2, 0), 1));
  world.add(new Sphere(redMaterial, new PVector(2, 0, 0), 1));
  world.add(new Cube(greenMaterial, new PVector(0, .5, 2), .5));
  //world.add(new DirectionalLight(new PVector(1, 1, 1)));
  world.add(new PointLight(new PVector(2, 5, 2), 10));
  //world.add(new PointLight(new PVector(2, 2, -4), 6));
  //world.add(new SpotLight(new PVector(10, 10, 10), new PVector(-1, -1, -1), 32, .01));
  println("Initializing "+threadCount+" render threads");
  for (int i=0; i<threadCount; i++) {
    renderThreads[i] = new RenderThread(i);
    renderThreads[i].start();
  }
}

int lastms = 0;
void draw() {
  int currentms = millis();
  float rmouseX = (pmouseX-mouseX)*(float)(currentms-lastms)/1000, rmouseY = (pmouseY-mouseY)*(float)(currentms-lastms)/1000;
  camera.rotateAround(rmouseX*.5); // Rotate camera
  lastms = currentms;
  try {
    startSem.release(threadCount); // Start all thread
    endSem.acquire(threadCount); // Wait for all to end
    for (RenderThread rt : renderThreads)
      rt.blit(); // Draw what was computed in each thread
  }
  catch(InterruptedException ie) {
    println("Something went wrong");
  }
  if (frameCount%32==1) {
    float frameDuration = (1/frameRate)*1000;
    float pixelDuration = (frameDuration / (width*height))*1000;
    println("FPS: "+frameRate+"\tFrame: "+frameDuration+"ms\tPixel: "+pixelDuration+"us");
  }
}