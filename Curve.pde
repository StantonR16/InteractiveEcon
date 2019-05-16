class Curve {
  private String m_name;
  private PVector m_value;
  
  public Curve(String name, PVector value) {
    m_name = name;
    m_value = value;
  }
  
  
  
  public void draw() {
    point(m_value.x,m_value.y);
  }
}
