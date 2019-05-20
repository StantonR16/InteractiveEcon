class Curve {
  private String m_name;
  private Line m_value;
  private boolean m_nameOffset;

  public Curve(String name, Line l) {
    this(name, l, false);
  }

  public Curve(String name, Line l, boolean nameOffset) {
    m_name = name;
    m_value = l;
    m_nameOffset = nameOffset;
  }

  public Line line() {
    return m_value;
  }

  public String name() { 
    return m_name;
  }

  public void draw() {
    m_value.draw();
    Point orig = m_value.getDestination();

    if (m_nameOffset) {
      Point delta = m_value.getDelta();
      text(m_name, orig.x-(delta.x+10), orig.y-(delta.y-10));
    } else text(m_name, orig.x+10, orig.y-5);
  }
}
