import java.util.*;

class Graph {
  private List<Curve> m_curves;

  private Point m_origin;
  private Line m_x, m_y;


  private int m_size;

  public Graph() {
    m_curves = new ArrayList<Curve>();
    m_origin = new Point(300, 300);
    m_size = 200;
    m_x = new Line(m_origin, m_size, 0, #FFFFFF);
    m_y = new Line(m_origin, 0, -m_size, #FFFFFF);
  }

  public void addSupply() {
    Line dest = new Line(m_origin, m_size, -m_size, #0000FF);
    m_curves.add(new Curve("S", dest));
  }

  public void addDemand() {

    Point transform = new Point(m_origin.x, m_origin.y - m_size);
    Line dest = new Line(transform, m_size, m_size, #FF0000);

    m_curves.add(new Curve("D", dest));
  }

  public void drawEquilibrium() {
  }






  private void drawAxes() {
    m_x.draw();
    m_y.draw();
  }



  public void drawVisualGuides(Curve c) {
    // Precondition: c is selected

    Point mouse = mouse();

    createVisualGuide(new Point(m_origin.x, mouse.y), "P").draw();

    createVisualGuide(new Point(mouse.x, m_origin.y), "Q").draw();
  }





  public void draw() {

    strokeWeight(5);

    for (Curve c : m_curves) {
      c.draw();
      printf("Curve %s is selected: %b", c.name(), c.line().isSelected());

      if (c.line().isSelected()) {
        drawVisualGuides(c);
      }
    }

    drawAxes();
  }
}
