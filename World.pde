class World {
  private PVector light;
  private ArrayList<Shape> shapes = new ArrayList<Shape>();
  World() {
    //shapes.add(new Plane(new PVector(0, 0, 0), new PVector(0, 1, 0)));
    shapes.add(new Disc(new PVector(0, 3, 0), new PVector(.1, .5, 1), 2));
    shapes.add(new Sphere(new PVector(0, 2, 0), 1));
    shapes.add(new Sphere(new PVector(2, 0, 0), 1));
    shapes.add(new Cube(new PVector(0, 0, 0), 1));
    light = new PVector(1, 1, 1);
    light.normalize();
  }
  void traceEye(PVector eye) {
    for (Shape shape : shapes)
      shape.traceEye(eye);
  }
  color trace(Ray ray) {
    color wtr = 0;
    float depth = 512;
    for (Shape shape : shapes) {
      Hit hit = shape.trace(ray);
      if (hit!=null && hit.depth<depth) { // The hit point is closer than the previous one
        depth = hit.depth;
        int v = 32+(int)(max(hit.normal.dot(light),0)*223f);
        wtr = color(v, v, v);
      }
    }
    return wtr;
  }
}  

