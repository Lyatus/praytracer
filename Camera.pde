/*
 We consider that X is right, Y is up, -Z is forward
 */
class Camera {
  private PVector position, interest, forward, right, up;
  private float width, height;
  Camera(PVector position, PVector interest, float ratio, float fovy) {
    this.position = position;
    this.height = 1;
    this.width = height*ratio;
    lookat(interest);
  }
  Ray ray(float x, float y) { // Returns ray from normalized screen position
    PVector direction = PVector.add(PVector.mult(forward, 2), PVector.add(PVector.mult(right, x*width), PVector.mult(up, y*height)));
    return new Ray(position, direction);
  }
  void lookat(PVector interest) {
    this.interest = interest;
    forward = PVector.sub(interest, position);
    forward.normalize();
    right = forward.cross(new PVector(0, 1, 0));
    right.normalize();
    up = right.cross(forward);
    up.normalize();
  }
  void rotateAround(float angle) {
    position.sub(interest);
    position = new PVector(position.x*cos(angle)-position.z*sin(angle), position.y, position.z*cos(angle)+position.x*sin(angle));
    position.add(interest);
    lookat(interest);
  }
}

