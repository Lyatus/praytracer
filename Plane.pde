class Plane extends Shape {
  protected PVector position, normal, inverseNormal;
  Plane(Material material, PVector position, PVector normal) {
    super(material);
    this.position = position;
    this.normal = normal;
    this.inverseNormal = PVector.mult(normal, -1);
  }
  Hit trace(Ray ray) {
    float dot = normal.dot(ray.direction);
    if (dot==0) // Parallel
      return null;
    else {
      float d = PVector.sub(position, ray.position).dot(normal)/dot;
      if (d<=0) // Hit behind
        return null;
      else {
        PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
        return new Hit(this, hitpos, (dot<0)?normal:inverseNormal, d);
      }
    }
  }
}

