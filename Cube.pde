class Cube extends Shape {
  private Plane[] planes = new Plane[6];
  private PVector position;
  private float radius;
  Cube(Material material, PVector position, float radius) {
    super(material);
    planes[0] = new Plane(material, PVector.add(position, new PVector(radius, 0, 0)), new PVector(1, 0, 0));
    planes[1] = new Plane(material, PVector.add(position, new PVector(-radius, 0, 0)), new PVector(-1, 0, 0));
    planes[2] = new Plane(material, PVector.add(position, new PVector(0, radius, 0)), new PVector(0, 1, 0));
    planes[3] = new Plane(material, PVector.add(position, new PVector(0, -radius, 0)), new PVector(0, -1, 0));
    planes[4] = new Plane(material, PVector.add(position, new PVector(0, 0, radius)), new PVector(0, 0, 1));
    planes[5] = new Plane(material, PVector.add(position, new PVector(0, 0, -radius)), new PVector(0, 0, -1));
    this.position = position;
    this.radius = radius+.001;
  }
  Hit trace(Ray ray) {
    Hit wtr = null;
    for (Plane plane : planes) {
      Hit tmp = plane.trace(ray);
      if (tmp!=null && (wtr==null || tmp.depth<wtr.depth)) { // If it's the first hit or it's closer
        PVector diff = PVector.sub(position, tmp.position);
        if (abs(diff.x)<=radius && abs(diff.y)<=radius && abs(diff.z)<=radius)
          wtr = tmp;
      }
    }
    return wtr;
  }
}

