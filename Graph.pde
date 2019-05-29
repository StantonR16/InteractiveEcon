import java.util.*;

class Graph {
  private List<Curve> m_curves;

  private Point m_origin;
  private Line m_x, m_y;


  private int m_size, m_size2;

  public Graph() {
    m_curves = new ArrayList<Curve>();
    m_size2 = 300;
    m_origin = new Point(m_size2, m_size2);
    m_size = 200;
    m_x = new Line(m_origin, m_size, 0, #FFFFFF);
    m_y = new Line(m_origin, 0, -m_size, #FFFFFF);
    
  }

  public void addSupply() {
   Point cpy = m_origin.copy();
   //cpy.x+= 100;
    Line dest = new Line(cpy, m_size, -m_size, #0000FF);
    
    m_curves.add(new Curve("S", dest));
  }
  
  private int m_taxDelta;
  
  private int getTaxDelta() {
    //return m_size / 2;
    return m_taxDelta;
  }
  
  private void clampTax() {
    if (m_taxDelta > m_size) 
    m_taxDelta = m_size;
    if (m_taxDelta < 0) m_taxDelta = 0;
  }
  
  public void increaseTax(){
    
    m_taxDelta++;
    clampTax();
  }
  
   public void decreaseTax(){
    m_taxDelta--;
    clampTax();
  }
  
  public void addSupplyTax() {
    
    for (int i = m_curves.size() - 1 ; i >=0; i--) {
      if (m_curves.get(i).name().equals("S tax")) {
        m_curves.remove(i);
      }
    }
    
   Point cpy = m_origin.copy();
   cpy.x -= (getTaxDelta());
    Line dest = new Line(cpy, m_size, -m_size, #0000FF);
    
    m_curves.add(new Curve("S tax", dest));
  }
  
  

  public void addDemand() {

    Point transform = new Point(m_origin.x, m_origin.y - m_size);
    Line dest = new Line(transform, m_size, m_size, #FF0000);
Curve c=new Curve("D", dest);
//c.follow();
    m_curves.add(c);
  }
  
  public void addTax() {
    // 350, 150
    addSupplyTax();
    drawEquilibriumTax();
  }
  
  public void drawEquilibriumTax() {
    // 350, 150
    
    Point cpy = m_origin.copy();
    
    //cpy.x += getTaxDelta() / 2;
    //cpy.y /= 2;
    
    cpy.x += (m_size/2);
    cpy.y -= (m_size/2);
    
    cpy.x -= getTaxDelta() / 2;
    cpy.y -= getTaxDelta() / 2;
    
    drawVisualGuidesInternal(cpy,"Ptax", "Qtax",cpy);
  }
  
  public void drawEquilibrium() {
    // 400, 200
    
    Point cpy = m_origin.copy();
    cpy.x += (m_size/2);
    cpy.y -= (m_size/2);
    
    drawVisualGuidesInternal(cpy,"Pe", "Qe",cpy,#00FF00);
  }
  
  
  private void drawAxes() {
    m_x.draw();
    m_y.draw();
  }
  
  private void drawVisualGuidesInternal(Point p, String pStr, String qStr, Point p2,color c) {
    // Precondition: c is selected

    createVisualGuide(new Point(m_origin.x, p.y), pStr,p2,c).draw();
    createVisualGuide(new Point(p.x, m_origin.y), qStr,p2,c).draw();
  }
  private void drawVisualGuidesInternal(Point p, String pStr, String qStr, Point p2) {
    // Precondition: c is selected

    createVisualGuide(new Point(m_origin.x, p.y), pStr,p2).draw();
    createVisualGuide(new Point(p.x, m_origin.y), qStr,p2).draw();
  }

  private void drawVisualGuidesInternal(Point p, String pStr, String qStr) {
    // Precondition: c is selected

    createVisualGuide(new Point(m_origin.x, p.y), pStr).draw();
    createVisualGuide(new Point(p.x, m_origin.y), qStr).draw();
  }

  public void drawVisualGuides() {
    drawVisualGuidesInternal(mouse(), "P", "Q");
  }
  
  private Point getOriginOffset() {
    Point cpy = m_origin.copy();
    cpy.x += (m_size/2);
    cpy.y -= (m_size/2);
    
    float delta = getTaxDelta() / 2;
    cpy.x -=  delta;
    cpy.y -= delta;
    
    return cpy;
  }
  
  public void drawDWL() {
    Point cpy = getOriginOffset();
    fill(color(0xFF,0xF4,0x2C,0x7F));
    
    triangle(m_size*2,m_size, 
            cpy.x, cpy.y + m_taxDelta,
            cpy.x, cpy.y);
            
    fill(color(0xFF,0xFF,0xFF,0xFF));
  }
  
  public void drawPS() {
    Point cpy = getOriginOffset();
    fill(color(0,0,0xFF,0x7F));
    // 1: origin;
    //printPoint(cpy.x, cpy.y + m_taxDelta);
    triangle(m_size2, m_size2, cpy.x, cpy.y + m_taxDelta, m_size2, cpy.y + m_taxDelta);
    fill(color(0xFF,0xFF,0xFF,0xFF));
  }
  
  public void drawCS() {
    
    Point cpy = getOriginOffset();
    
    
    fill(color(0xFF,0,0,0x7F));
    triangle(m_size2, m_size2-m_size, cpy.x, cpy.y, m_size2, cpy.y);
    fill(color(0xFF,0xFF,0xFF,0xFF));
  }

  public void drawTaxRevenue() {
    Point cpy = getOriginOffset();
    
    
    fill(color(0x00,0xFF,0,0x7F));
    rect(m_size2, cpy.y,cpy.x - 300, m_taxDelta);
    
    fill(color(0xFF,0xFF,0xFF,0xFF));
  }



  public void draw() {

    
    strokeWeight(5);

    for (Curve c : m_curves) {
      c.draw();
      //printf("Curve %s is selected: %b", c.name(), c.line().isSelected());

      if (c.line().isSelected()) {
        drawVisualGuides();
      }
    }

    
    drawEquilibrium();
    addTax();
    drawCS();
    drawPS();
    drawDWL();
    drawTaxRevenue();
    drawAxes();
    
    //println("Tax delta: "+m_taxDelta);
  }
}
