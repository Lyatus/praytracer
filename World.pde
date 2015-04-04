class World {
  private ArrayList<Light> lights = new ArrayList<Light>();
  private ArrayList<Shape> shapes = new ArrayList<Shape>();
  World() {
    Material defaultMaterial = new Material(#FFFFFF, 0);
    Material redMaterial = new Material(#FF0000, .5);
    shapes.add(new Plane(defaultMaterial, new PVector(0, 0, 0), new PVector(0, 1, 0)));
    shapes.add(new Disc(defaultMaterial, new PVector(0, 3, 0), new PVector(.1, .5, 1), 2));
    shapes.add(new Sphere(defaultMaterial, new PVector(0, 2, 0), 1));
    shapes.add(new Sphere(redMaterial, new PVector(2, 0, 0), 1));
    //shapes.add(new Cube(new PVector(0, 0, 0), 1));
    //lights.add(new DirectionalLight(new PVector(1, 1, 1)));
    lights.add(new PointLight(new PVector(2, 5, 2), 10));
    lights.add(new PointLight(new PVector(2, 2, -4), 6));
    //lights.add(new SpotLight(new PVector(10, 10, 10), new PVector(-1, -1, -1), 32, .01));
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
      return color(red(hit.shape.material.c)*term, green(hit.shape.material.c)*term, blue(hit.shape.material.c)*term);
    }
    return 0;
  }
}  

