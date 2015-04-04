class Disc extends Plane {
  private float radius;
  Disc(Material material, PVector position, PVector normal, float radius) {
    super(material, position, normal);
    this.radius = radius;
  }
  Hit trace(Ray ray) {
    Hit wtr = super.trace(ray);
    if (wtr!=null && wtr.position.dist(position)>radius) // Hit point is too far on the plane
      return null;
    return wtr;
  }
}

