class SpotLight extends Light {
  private PVector position, direction;
  private float radius;
  private float angle;
  SpotLight(PVector position, PVector direction, float radius, float angle) {
    this.position = position;
    this.direction = direction;
    this.direction.normalize();
    this.radius = radius;
    this.angle = angle;
  }
  float diffuse(World world, Ray ray, Hit hit) {
    float wtr = (radius-PVector.dist(hit.position, position))/radius;
    if (wtr<=0) return 0; // Too far
    PVector hitToLight = PVector.sub(position, hit.position);
    float distance = hitToLight.mag();
    hitToLight.normalize();
    if(hitToLight.dot(direction)>-1+angle) return 0;
    if(shadowed(world,hit,hitToLight,distance)) return 0;
    else return max(wtr*hit.normal.dot(hitToLight), 0);
  }
}

