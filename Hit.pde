class Hit {
  Shape shape;
  PVector position;
  PVector normal;
  float depth; // Depth represents the distance between hit point and ray start
  Hit(Shape shape, PVector position, PVector normal, float depth) {
    this.shape = shape;
    this.position = position;
    this.normal = normal;
    this.normal.normalize();
    this.depth = depth;
  }
}
