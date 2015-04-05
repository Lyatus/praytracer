import java.util.concurrent.Semaphore;

int width = 16*50, height = 9*50, threadCount = Runtime.getRuntime().availableProcessors();
Semaphore startSem = new Semaphore(0);
Semaphore endSem = new Semaphore(0);
Camera camera = new Camera(new PVector(5, 2, 5), new PVector(0, 0, 0), (float)width/height, 60);
World world = new World();

void setup() {
  size(width, height);
  println("Initializing world");
  Material defaultMaterial = new Material(#FFFFFF, 0);
  Material redMaterial = new Material(#FF0000, .5);
  world.add(new Plane(defaultMaterial, new PVector(0, 0, 0), new PVector(0, 1, 0)));
  world.add(new Disc(redMaterial, new PVector(0, 3, 0), new PVector(.1, .5, 1), 2));
  world.add(new Sphere(defaultMaterial, new PVector(0, 2, 0), 1));
  world.add(new Sphere(redMaterial, new PVector(2, 0, 0), 1));
  //world.add(new Cube(new PVector(0, 0, 0), 1));
  //world.add(new DirectionalLight(new PVector(1, 1, 1)));
  world.add(new PointLight(new PVector(2, 5, 2), 10));
  //world.add(new PointLight(new PVector(2, 2, -4), 6));
  //world.add(new SpotLight(new PVector(10, 10, 10), new PVector(-1, -1, -1), 32, .01));
  println("Initializing "+threadCount+" render threads");
  for (int i=0; i<threadCount; i++)
    new RenderThread(i).start();
}

void draw() {
  camera.rotateAround(.05); // Rotate camera
  try {
    int startms = millis();
    startSem.release(threadCount); // Start all thread
    endSem.acquire(threadCount); // Wait for all to end
    //println("Frame duration: "+(millis()-startms));
  }
  catch(InterruptedException ie) {
  }
  if (frameCount%64==1){
    println("Average frame duration: "+((float)millis()/frameCount));
    println("FPS: "+frameRate);
  }
}

