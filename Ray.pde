class Ray {
  private PVector position, direction;
  Ray(PVector position, PVector direction) {
    this.position = position;
    this.direction = direction;
    this.direction.normalize();
  }
}
