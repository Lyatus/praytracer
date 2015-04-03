class RenderThread extends Thread {
  private int id;
  RenderThread(int id) {
    this.id = id;
  }
  public void run() {
    float halfWidth = width/2;
    float halfHeight = height/2;
    try {
      while (true) {
        sem.acquire();
        for (int y=id; y<height; y+=threadCount)
          for (int x=0; x<width; x++) 
            set(x, y, world.trace(camera.ray((float)x/halfWidth-1, -((float)y/halfHeight-1))));
        sem.release();
      }
    }
    catch(InterruptedException ie) {
    }
  }
}

