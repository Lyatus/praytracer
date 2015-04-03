import java.util.concurrent.Semaphore;

int width = 800, height = 600, threadCount = 4;
Semaphore sem = new Semaphore(threadCount, true);
Camera camera = new Camera(new PVector(5, 10, 5), new PVector(0, 0, 0), (float)width/height, 60);
World world = new World();

void setup() {
  size(width, height);
  world.traceEye(camera.position);
  for (int i=0; i<threadCount; i++)
    new RenderThread(i).start();
}
void draw() {
  try {
    sem.acquire(threadCount);
    world.traceEye(camera.position);
    camera.rotateAround(.05);
    sem.release(threadCount);
  }
  catch(InterruptedException ie) {
  }
}

