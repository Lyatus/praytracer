import java.util.concurrent.Semaphore;

int width = 16*50, height = 9*50, threadCount = 4;
Semaphore sem = new Semaphore(threadCount, true);
Camera camera = new Camera(new PVector(5, 2, 5), new PVector(0, 0, 0), (float)width/height, 60);
World world = new World();

void setup() {
  size(width, height);
  for (int i=0; i<threadCount; i++)
    new RenderThread(i).start();
}
void draw() {
  try {
    sem.acquire(threadCount); // Stop all rendering
    camera.rotateAround(.05); // Rotate camera
    sem.release(threadCount); // Restart rendering
  }
  catch(InterruptedException ie) {
  }
}

