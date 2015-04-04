class Sphere extends Shape {
  private PVector center;
  private float radius, radiusSq;
  Sphere(Material material, PVector center, float radius) {
    super(material);
    this.center = center;
    this.radius = radius;
    this.radiusSq = pow(radius, 2);
  }
  Hit trace(Ray ray) {
    PVector oc = PVector.sub(ray.position, center);
    float ldotoc = ray.direction.dot(oc);
    float delta = pow(ldotoc, 2)-oc.magSq()+radiusSq;
    if (delta<0)
      return null;
    else {
      float d = -ldotoc;
      if (delta>0) // Avoid sqrt call if it would return 0 anyway
        d -= sqrt(delta);
      if (d<0) // The point is before the start of the ray
        return null;
      PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
      return new Hit(this, hitpos, PVector.sub(hitpos, center), d);
    }
  }
}

