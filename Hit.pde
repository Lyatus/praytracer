class Hit {
  PVector position;
  PVector normal;
  float depth;
  Hit(PVector position, PVector normal, float depth) {
    this.position = position;
    this.normal = normal;
    this.normal.normalize();
    this.depth = depth;
  }
}
