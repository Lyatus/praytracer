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
  Hit(PVector position, PVector normal, float depth) {
    this.position = position;
    this.normal = normal;
    this.normal.normalize();
    this.depth = depth;
  }
}
abstract class Shape {
  abstract Hit trace(Ray ray);
}
class Plane extends Shape {
  private PVector position, normal;
  Plane(PVector position, PVector normal) {
    this.position = position;
    this.normal = normal;
  }
  Hit trace(Ray ray) {
    // d = ((p0-l0).n)/(l.n)
    float dot = normal.dot(ray.direction);
    if (dot==0) // Parallel
      return null;
    else {
      float d = PVector.sub(position, ray.position).dot(normal)/dot;
      if (d<=0) // Hit behind
        return null;
      else {
        PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
        return new Hit(hitpos, normal, PVector.dist(ray.position, hitpos));
      }
    }
  }
}
class Disc extends Shape {
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
class Sphere extends Shape {
  private PVector center;
  private float radius;
  Sphere(PVector center, float radius) {
    this.center = center;
    this.radius = radius;
  }
  Hit trace(Ray ray) {
    PVector oc = PVector.sub(ray.position, center);
    float ldotoc = ray.direction.dot(oc);
    float delta = pow(ldotoc, 2)-oc.magSq()+pow(radius, 2);
    if (delta<0)
      return null;
    else {
      float d = -ldotoc;
      if (delta>0)
        d -= sqrt(delta);
      PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
      return new Hit(hitpos, PVector.sub(hitpos, center), PVector.dist(ray.position, hitpos));
    }
  }
}
class Camera {
  private PVector position, forward, right, up;
  private float hangle, vangle;
  Camera(PVector position, PVector forward, float ratio, float fovy) {
    this.position = position;
    lookat(forward);
    this.vangle = fovy/2;
    this.hangle = vangle*ratio;
  }
  Ray ray(float x, float y) { // Returns ray from normalized screen position
    PVector direction = PVector.add(PVector.mult(forward, 2), PVector.add(PVector.mult(right, x), PVector.mult(up, y)));
    return new Ray(position, direction);
  }
  void lookat(PVector p) {
    this.forward = p;
    this.forward.normalize();
    this.right = this.forward.cross(new PVector(0, 1, 0));
    this.right.normalize();
    this.up = this.right.cross(this.forward);
    this.up.normalize();
  }
}
class World {
  private PVector light;
  private ArrayList<Shape> shapes = new ArrayList<Shape>();
  World() {
    //shapes.add(new Plane(new PVector(0, 0, 0), new PVector(0, 1, 0)));
    //shapes.add(new Disc(new PVector(0, .5, 0), new PVector(0, 1, 0), 2));
    shapes.add(new Sphere(new PVector(0, 0, 0), 1));
    shapes.add(new Sphere(new PVector(1, 0, 1), 1));
    light = new PVector(1, 1, 1);
    light.normalize();
  }
  color trace(Ray ray) {
    color wtr = (int)random(255);
    float depth = 9999999;
    for (Shape shape : shapes) {
      Hit hit = shape.trace(ray);
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

