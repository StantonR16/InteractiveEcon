class Point {
  public float x, y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public String toString() {
    return String.format("x: %f, y: %f",x,y);
  }
}
