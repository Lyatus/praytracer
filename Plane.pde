class Plane extends Shape {
  private PVector position, normal, inverseNormal;
  Plane(PVector position, PVector normal) {
    this.position = position;
    this.normal = normal;
    this.inverseNormal = PVector.mult(normal,-1);
  }
  private PVector psubeye;
  void traceEye(PVector eye) {
    psubeye = PVector.sub(position, eye);
  }
  Hit trace(Ray ray) {
    float dot = normal.dot(ray.direction);
    if (dot==0) // Parallel
      return null;
    else {
      float d = psubeye.dot(normal)/dot;
      if (d<=0) // Hit behind
        return null;
      else {
        PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
        return new Hit(hitpos, (dot<0)?normal:inverseNormal, d);
      }
    }
  }
}

