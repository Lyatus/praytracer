class DirectionalLight extends Light {
  private PVector direction;
  DirectionalLight(PVector direction) {
    this.direction = direction;
    this.direction.mult(999999); // Light considered far away
  }
  PVector toLight(Hit hit){
    return PVector.mult(direction,1); // Ugly copy
  }
  float attenuation(Hit hit){
     return 1; // There is no maximum distance to a directional light
  }
}

