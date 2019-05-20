class Point {
  public float x, y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Point inverse() {
    return new Point(y,x);
  }
  
  public String toString() {
    return String.format("x: %f, y: %f",x,y);
  }
}
