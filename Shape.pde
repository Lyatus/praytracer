abstract class Shape {
  Material material;
  Shape(Material material) {
    this.material = material;
  }
  abstract Hit trace(Ray ray);
}

