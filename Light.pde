abstract class Light {
  abstract float diffuse(World world, Ray ray, Hit hit);
  PVector reflect(PVector i, PVector n) { // Computes the reflection vector from the incident and the normal
    PVector wtr = PVector.sub(PVector.mult(n, n.dot(i)*2), i);
    wtr.normalize();
    return wtr;
  }
  boolean shadowed(World world, Hit hit, PVector hitToLight, float lightDistance) {
    Hit hit2 = world.trace(new Ray(PVector.add(hit.position, PVector.mult(hit.normal, .00001)), hitToLight)); // Trace to light
    return hit2!=null && hit2.depth<lightDistance; // There was a hit before attaining the light position (object obstructing)
  }
}

