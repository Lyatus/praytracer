class Sphere extends Shape {
  private PVector center;
  private float radius, radiusSq;
  Sphere(PVector center, float radius) {
    this.center = center;
    this.radius = radius;
    this.radiusSq = pow(radius, 2);
  }
  
  // Sphere tracing helpers
  private PVector oc;
  void traceEye(PVector eye){
    oc = PVector.sub(eye, center);
  }
  Hit trace(Ray ray) {
    float ldotoc = ray.direction.dot(oc);
    float delta = pow(ldotoc, 2)-oc.magSq()+radiusSq;
    if (delta<0)
      return null;
    else {
      float d = -ldotoc;
      if (delta>0)
        d -= sqrt(delta);
      PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
      return new Hit(hitpos, PVector.sub(hitpos, center), d);
    }
  }
}
