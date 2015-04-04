class Hit {
  Shape shape;
  PVector position;
  PVector normal;
  float depth;
  Hit(Shape shape, PVector position, PVector normal, float depth) {
    this.shape = shape;
    this.position = position;
    this.normal = normal;
    this.normal.normalize();
    this.depth = depth;
  }
}
