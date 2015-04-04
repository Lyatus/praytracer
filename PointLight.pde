class PointLight extends Light {
  protected PVector position;
  protected float radius;
  PointLight(PVector position, float radius) {
    this.position = position;
    this.radius = radius;
  }
  PVector toLight(Hit hit) {
    return PVector.sub(position, hit.position);
  }
  float attenuation(Hit hit) {
    return (radius-PVector.dist(hit.position, position))/radius; // Map distance to light from 1 (in the light) to 0 (farthest to light)
  }
}

