abstract class Light {
  abstract float attenuation(Hit hit);
  abstract PVector toLight(Hit hit);
  PVector reflect(PVector i, PVector n) { // Computes the reflection vector from the incident and the normal
    PVector wtr = PVector.sub(PVector.mult(n, n.dot(i)*2), i);
    wtr.normalize();
    return wtr;
  }
  boolean shadowed(World world, Hit hit, PVector hitToLight, float lightDistance) {
    Hit hit2 = world.trace(new Ray(PVector.add(hit.position, PVector.mult(hit.normal, .00001)), hitToLight)); // Trace to light
    return hit2!=null && hit2.depth<lightDistance; // There was a hit before attaining the light position (object obstructing)
  }
  float shade(World world, Ray ray, Hit hit) {
    float atten = attenuation(hit);
    if (atten<=0) return 0; // Too far
    PVector hitToLight = toLight(hit); // Vector between hit and light position
    float distance = hitToLight.mag(); // Distance between hit and light position
    hitToLight.normalize(); // Normalize to use dot product afterwards

    float diffuse = hit.normal.dot(hitToLight); // Find diffuse factor
    float specular = (hit.shape.material.shininess>0)?(max(0, pow(reflect(PVector.mult(hitToLight, -1), hit.normal).dot(ray.direction), 32))*hit.shape.material.shininess):0;
    float difspec = diffuse + specular;
    if (difspec<=0) return 0; // No point in continuing if no diffuse nor specular is present
    if (shadowed(world, hit, hitToLight, distance)) return 0; // Test if the hit point is shadowed by an object
    return max(0, atten*min(1, difspec));  // Clamp result between 0 and 1
  }
}

