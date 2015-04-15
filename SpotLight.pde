class SpotLight extends PointLight {
  private PVector direction;
  private float angle;
  SpotLight(PVector position, PVector direction, float radius, float angle) {
    super(position, radius);
    this.direction = direction;
    this.direction.normalize();
    this.angle = angle;
  }
  float attenuation(Hit hit) {
    float wtr = super.attenuation(hit);
    if (wtr<=0) return 0; // Too far
    PVector hitToLight = toLight(hit); // Vector between hit and light position
    hitToLight.normalize();
    if (hitToLight.dot(direction)>-1+angle) return 0; // Outside the spot
    return wtr;
  }
}

