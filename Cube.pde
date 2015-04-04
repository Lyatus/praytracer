class Cube extends Shape {
  private Plane[] planes = new Plane[6];
  private PVector position;
  private float radius;
  Cube(Material material, PVector position, float radius) {
    super(material);
    /*
    planes[0] = new Plane(PVector.add(position, new PVector(radius, 0, 0)), new PVector(1, 0, 0));
    planes[1] = new Plane(PVector.add(position, new PVector(-radius, 0, 0)), new PVector(-1, 0, 0));
    planes[2] = new Plane(PVector.add(position, new PVector(0, radius, 0)), new PVector(0, 1, 0));
    planes[3] = new Plane(PVector.add(position, new PVector(0, -radius, 0)), new PVector(0, -1, 0));
    planes[4] = new Plane(PVector.add(position, new PVector(0, 0, radius)), new PVector(0, 0, 1));
    planes[5] = new Plane(PVector.add(position, new PVector(0, 0, -radius)), new PVector(0, 0, -1));
    */
    this.position = position;
    this.radius = radius;
  }
  Hit trace(Ray ray) {
    Hit wtr = null;
    for (Plane plane : planes) {
      Hit tmp = plane.trace(ray);
      if (tmp!=null && PVector.dist(position, tmp.position)<=radius)
          wtr = tmp;
    }
    return wtr;
  }
}

