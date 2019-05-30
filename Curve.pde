class Curve {
  private String m_name;
  private Line m_value;
  private boolean m_nameOffset, m_useLabel;

  public Curve(String name, Line l) {
    this(name, l, false);
  }

  public Curve(String name, Line l, boolean nameOffset) {
    m_name = name;
    m_value = l;
    m_nameOffset = nameOffset;
    m_useLabel = true;
  }

  public void toggleLabel() {
    m_useLabel = !m_useLabel;
  }

  public Line line() {
    return m_value;
  }

  public String name() {
    return m_name;
  }

  public void draw() {
    m_value.draw();

    if (m_useLabel) {
      Point orig = m_value.getDestination();

      if (m_nameOffset) {
        Point delta = m_value.getDelta();
        text(m_name, orig.x-(delta.x+textWidth(m_name)+10), orig.y-(delta.y-12));
      } else {
        
        //printf("%s %s", m_name,  dest);
        text(m_name, orig.x+10, orig.y-5);
        //text(m_name, dest.x+10, dest.y-5);
      }
    }
  }
}
