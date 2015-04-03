/*
 We consider X is right, Y is up, -Z is forward
 */

class Ray {
  private PVector position, direction;
  Ray(PVector position, PVector direction) {
    this.position = position;
    this.direction = direction;
    this.direction.normalize();
  }
}
class Hit {
  PVector position;
  PVector normal;
  float depth;
}
class Plane {
  private float a, b, c, d;
  Plane(PVector p, PVector n) {
  }
  Hit trace(Ray ray) {

    return null;
  }
}
class Disc {
  private Plane plane;
  private PVector position;
  private float radius;
  Disc(PVector position, PVector normal, float radius) {
    plane = new Plane(position, normal);
    this.position = position;
    this.radius = radius;
  }
  Hit trace(Ray ray) {
    Hit wtr = plane.trace(ray);
    if (wtr!=null && wtr.position.dist(position)>radius) // Hit point is too far on the plane
      return null;
    return wtr;
  }
}
class Camera {
  private PVector position, forward, right, up;
  private float hangle, vangle;
  Camera(PVector position, PVector forward, float ratio, float fovy) {
    this.position = position;
    this.forward = forward;
    this.forward.normalize();
    this.right = this.forward.cross(new PVector(0, 1, 0));
    this.right.normalize();
    this.up = this.right.cross(this.forward);
    this.up.normalize();
    this.vangle = fovy/2;
    this.hangle = vangle*ratio;
  }
  Ray ray(float x, float y) { // Returns ray from normalized screen position
    PVector direction = PVector.add(PVector.mult(forward,2), PVector.add(PVector.mult(right, x), PVector.mult(up, y)));
    return new Ray(position, direction);
  }
}
class World {
  private PVector light;
  private ArrayList<Disc> discs = new ArrayList<Disc>();
  World() {
    discs.add(new Disc(new PVector(0, 0, 0), new PVector(0, 1, 0), 1));
    light = new PVector(-1, -1, -1);
    light.normalize();
  }
  color trace(Ray ray) {
    color wtr = (int)random(255);
    float depth = 9999999;
    for (Disc disc : discs) {
      Hit hit = disc.trace(ray);
      if (hit!=null && hit.depth<depth) { // The hit point is closer than the previous one
        depth = hit.depth;
        int v = (int)(hit.normal.dot(light)*255f);
        wtr = color(v, v, v);
      }
    }
    return wtr;
  }
}

int width = 300, height = 300;
Camera camera = new Camera(new PVector(5, 5, 5), new PVector(-1, -1, -1), (float)width/height, 60);
World world = new World();
void setup() {
  size(width, height);
}
void draw() {
  for (int x=0; x<width; x++)
    for (int y=0; y<height; y++)
      set(x, y, world.trace(camera.ray(((float)x/width)*2-1, ((float)y/height)*2-1)));
}

