class World {
  private ArrayList<Light> lights = new ArrayList<Light>();
  private ArrayList<Shape> shapes = new ArrayList<Shape>();
  void add(Light light) {
    lights.add(light);
  }
  void add(Shape shape) {
    shapes.add(shape);
  }
  Hit trace(Ray ray) {
    Hit wtr = null;
    for (Shape shape : shapes) {
      Hit hit = shape.trace(ray);
      if (hit!=null && (wtr==null || hit.depth<wtr.depth)) // First hit point or is closer than the previous one
        wtr = hit;
    }
    return wtr;
  }
  color shade(Ray ray) {
    Hit hit = trace(ray);
    if (hit!=null) {
      float diffuse = 0;
      for (Light light : lights)
        diffuse = max(diffuse, light.shade(this, ray, hit));
      float term = .1 + diffuse*.9;
      return color((hit.shape.material.c >> 16 & 0xFF)*term, (hit.shape.material.c >> 8 & 0xFF)*term, (hit.shape.material.c & 0xFF)*term);
    }
    return 0;
  }
}

