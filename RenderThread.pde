class RenderThread extends Thread {
  private int id;
  RenderThread(int id) {
    this.id = id;
  }
  public void run() {
    float w = 1/((float)width/2); // Map ahead, multiplications are faster than divisions
    float h = 1/((float)height/2);
    try {
      while (true) {
        startSem.acquire();
        for (int y=id; y<height; y+=threadCount)
          for (int x=0; x<width; x++) 
            set(x, y, world.shade(camera.ray(x*w-1, -(y*h-1))));
        endSem.release();
      }
    }
    catch(InterruptedException ie) {
    }
  }
}

