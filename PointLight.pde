class PointLight extends Light {
  private PVector position;
  private float radius;
  PointLight(PVector position, float radius) {
    this.position = position;
    this.radius = radius;
  }
  float diffuse(World world, Ray ray, Hit hit) {
    float wtr = (radius-PVector.dist(hit.position, position))/radius; // Map distance to light from 1 (in the light) to 0 (farthest to light)
    if (wtr<=0) return 0; // Too far
    PVector hitToLight = PVector.sub(position, hit.position);
    float distance = hitToLight.mag();
    hitToLight.normalize();
    if(shadowed(world,hit,hitToLight,distance)) return 0;
    else return max(wtr*hit.normal.dot(hitToLight), 0);
  }
}

