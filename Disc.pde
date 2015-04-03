class Disc extends Shape {
  private Plane plane;
  private PVector position;
  private float radius;
  Disc(PVector position, PVector normal, float radius) {
    plane = new Plane(position, normal);
    this.position = position;
    this.radius = radius;
  }
  void traceEye(PVector eye) {
    plane.traceEye(eye);
  }
  Hit trace(Ray ray) {
    Hit wtr = plane.trace(ray);
    if (wtr!=null && wtr.position.dist(position)>radius) // Hit point is too far on the plane
      return null;
    return wtr;
  }
}

