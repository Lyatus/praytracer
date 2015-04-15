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
    if (delta<0) // Couldn't call sqrt on it
      return null;
    else {
      float d = -ldotoc - sqrt(delta);
      if (d<0) return null; // The point is before the start of the ray
      PVector hitpos = PVector.add(ray.position, PVector.mult(ray.direction, d));
      return new Hit(this, hitpos, PVector.sub(hitpos, center), d);
    }
  }
}

