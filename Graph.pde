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
    if (m_taxDelta > m_size) {
      m_taxDelta = m_size;
      m_isMovingRight = false;
    }
      
    if (m_taxDelta < 0) {
      m_taxDelta = 0;
      m_isMovingRight = true;
    }
  }

  public void increaseTax() {

    m_taxDelta++;
    clampTax();
  }

  public void decreaseTax() {
    m_taxDelta--;
    clampTax();
  }
  
  private boolean m_isMovingRight;
  
  public void changeTax() {
    if (m_isMovingRight) increaseTax();
    else decreaseTax();
  }

  private Curve get(String name) {
    for (int i = m_curves.size() - 1; i >=0; i--) {
      if (m_curves.get(i).name().equals(name)) {
        return m_curves.get(i);
      }
    }
    return null;
  }

  private void removeSupplyTax() {
    for (int i = m_curves.size() - 1; i >=0; i--) {
      if (m_curves.get(i).name().equals("S tax")) {
        m_curves.remove(i);
      }
    }
  }

  public void addSupplyTax() {

    removeSupplyTax();

    Point cpy = m_origin.copy();
    cpy.x -= (getTaxDelta());
    Line dest = new Line(cpy, m_size, -m_size, #0000FF);

    m_curves.add(new Curve("S tax", dest));
  }



  public void addDemand() {

    Point transform = new Point(m_origin.x, m_origin.y - m_size);
    Line dest = new Line(transform, m_size, m_size, #FF0000);
    //Line dest = asStandard(transform,mouse(),#FF0000);
    Curve c=new Curve("D", dest);
    //c.follow();
    m_curves.add(c);
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

    drawVisualGuidesInternal(cpy, "Ptax", "Qtax", cpy);
  }

  public void drawEquilibrium() {
    // 400, 200

    Point cpy = m_origin.copy();
    cpy.x += (m_size/2);
    cpy.y -= (m_size/2);

    drawVisualGuidesInternal(cpy, "Pe", "Qe", cpy, #00FF00);
  }


  private void drawAxes() {
    m_x.draw();
    m_y.draw();
  }

  private void drawVisualGuidesInternal(Point p, String pStr, String qStr, Point p2, color c) {
    // Precondition: c is selected

    createVisualGuide(new Point(m_origin.x, p.y), pStr, p2, c).draw();
    createVisualGuide(new Point(p.x, m_origin.y), qStr, p2, c).draw();
  }
  private void drawVisualGuidesInternal(Point p, String pStr, String qStr, Point p2) {
    // Precondition: c is selected

    createVisualGuide(new Point(m_origin.x, p.y), pStr, p2).draw();
    createVisualGuide(new Point(p.x, m_origin.y), qStr, p2).draw();
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

  private void restore() {
    fill(WHITE_COLOR);
    stroke(#808080);
  }

  private final color DWL_COLOR = color(0xFF, 0xF4, 0x2C, 0x7F);
  private final color PS_COLOR = color(0, 0, 0xFF, 0x7F);
  private final color WHITE_COLOR = color(0xFF, 0xFF, 0xFF, 0xFF);
  private final color CS_COLOR = color(0xFF, 0, 0, 0x7F);
  private final color TAX_REVENUE_COLOR = color(0x00, 0xFF, 0, 0x7F);
  
  public void drawDWL() {
    Point cpy = getOriginOffset();
    fill(DWL_COLOR);

    noStroke();
    triangle(m_size*2, m_size, 
      cpy.x, cpy.y + m_taxDelta, 
      cpy.x, cpy.y);

    restore();
  }

  
  
  public void drawPS() {
    Point cpy = getOriginOffset();
    noStroke();
    fill(PS_COLOR);
    // 1: origin;
    //printPoint(cpy.x, cpy.y + m_taxDelta);
    triangle(m_size2, m_size2, cpy.x, cpy.y + m_taxDelta, m_size2, cpy.y + m_taxDelta);
    restore();
  }
  
  
  
  
  private void addLabel(String txt, color c, int i) {
    noStroke();
    rectMode(CENTER);
    fill(c);
    final int S = 20;
    rect(25 + (S / 2), 100 + i, S, S);
    fill(#FFFFFF);
    rectMode(CORNER);
    text(txt,25 + S + (S  /2), 100 + i + (S / 4));
  }
  
  private void addLabelAlt(String txt, int i) {
    
    final int S = 20;
    
    fill(#FFFFFF);
    rectMode(CORNER);
    text("-", 22 + (S / 2), 100 + i + (S / 4));
    text(txt, 25 + S + (S / 2), 100 + i + (S / 4));
  }
  
  public void drawInfo() {
    Point origDelta = getOriginOffset();
    
    float len = origDelta.x - m_origin.x;
    float h = m_taxDelta;
    float taxRevenue = len * h;
    float surplus = (len * len) / 2;
    float dwl = (m_taxDelta * len) / 2;
    
    
    final int OFFSET_MULTIPLIER = 25;
    
    addLabel(String.format("Tax revenue: %.1f", taxRevenue), TAX_REVENUE_COLOR, OFFSET_MULTIPLIER * 0);
    addLabel(String.format("Consumer surplus: %.1f", surplus), CS_COLOR, OFFSET_MULTIPLIER * 1);
    addLabel(String.format("Producer surplus: %.1f", surplus), PS_COLOR, OFFSET_MULTIPLIER * 2);
    addLabel(String.format("Deadweight loss: %.1f", dwl), DWL_COLOR, OFFSET_MULTIPLIER * 3);
    addLabel(String.format("Tax: %d", m_taxDelta), WHITE_COLOR, OFFSET_MULTIPLIER * 4);
    addLabelAlt("Short-run", OFFSET_MULTIPLIER * 5);
    addLabelAlt("Unit elastic", OFFSET_MULTIPLIER * 6);
  }

  
  
  public void drawCS() {

    Point cpy = getOriginOffset();

    noStroke();
    fill(CS_COLOR);
    triangle(m_size2, m_size2-m_size, cpy.x, cpy.y, m_size2, cpy.y);
    restore();
  }

  public void drawTaxRevenue() {
    Point cpy = getOriginOffset();


    noStroke();
    fill(TAX_REVENUE_COLOR);
    rect(m_size2, cpy.y, cpy.x - 300, m_taxDelta);

    restore();
  }

  private boolean isTaxed() {
    return (m_taxDelta != 0);
  }

  public void draw() {

    strokeWeight(5);

    if (!isTaxed()) {

      removeSupplyTax();
    } else {
      
      addSupplyTax();
      drawDWL();
      drawTaxRevenue();
    }

    drawCS();
    drawPS();

    for (Curve c : m_curves) {
      c.draw();
      //printf("Curve %s is selected: %b", c.name(), c.line().isSelected());

      if (c.line().isSelected()) {
        drawVisualGuides();
      }
    }

    
    if (isTaxed()) drawEquilibriumTax();

    drawEquilibrium();
    drawAxes();
    drawInfo();
    //println("Tax delta: "+m_taxDelta);
    
    //text("Effects of a per-unit tax on a unit-elastic firm",20,395);
    
    textSize(25);
    text("Economics",25,40);
    textSize(18);
    text("Per-unit tax",25,60);
    textSize(12);
  }
}
