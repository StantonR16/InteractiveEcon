class Line {
  private Point m_orig;
  private Point m_delta;
  private color m_color;

  public Line(Point origin, float deltaX, float deltaY, color c) {
    this(origin, new Point(deltaX, deltaY), c);
  }



  public Line(Point origin, Point delta, color c) {
    m_orig = origin;
    m_delta = delta;
    m_color = c;
  }

  public Line copy() {
    return new Line(m_orig, m_delta, m_color);
  }

  public Point getOrigin() { 
    return m_orig;
  }
  public Point getDelta() { 
    return m_delta;
  }

  public boolean isSelected() {
    return linePoint(this, mouse());
  }

  public Point getDestination() {
    return new Point(m_orig.x+m_delta.x, m_orig.y+m_delta.y);
  }

  public void draw() {
    Point dest = getDestination();
    stroke(m_color);
    line(m_orig.x, m_orig.y, dest.x, dest.y);
  }
}
