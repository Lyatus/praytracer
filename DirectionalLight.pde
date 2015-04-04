class DirectionalLight extends Light {
  private PVector direction;
  DirectionalLight(PVector direction) {
    this.direction = direction;
    this.direction.normalize();
  }
  float diffuse(World world, Ray ray, Hit hit) {
    if(shadowed(world,hit,direction,Float.POSITIVE_INFINITY)) return 0;
    else return max(hit.normal.dot(direction), 0);
  }
}

