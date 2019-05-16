import java.util.*;

class Graph {
  private List<Curve> m_curves;

  private Point m_origin;

  private boolean m_isBeingDragged;
  
  private int m_size;

  public Graph() {
    m_curves = new ArrayList<Curve>();
    m_origin = new Point(300, 300);
    m_size = 200;
  }



  public boolean isBeingDragged() { 
    return m_isBeingDragged;
  }

  public void drag() {
    m_isBeingDragged = true;
  }

  public void drop() {
    m_isBeingDragged = false;
    m_origin = mouse();
  }

  public Point getOrigin() {
    if (m_isBeingDragged) {
      return mouse();
    }
    //return mouse();
    return m_origin;
  }

  

  private void drawAxes() {
    Point orig = getOrigin();
    //todo
    line(orig.x, orig.y, orig.x+m_size, orig.y); // x
    line(orig.x, orig.y, orig.x, orig.y-m_size); // y
  }

  boolean isHoveringX() {
    Point src = mouse();
    Point orig = getOrigin();
    return isHovering_X(orig.x,orig.y,m_size,5);
  }

  

  boolean bover;
  boolean locked;



  public void draw() {
    stroke(255);
    strokeWeight(5);

    float bx = getOrigin().x;
    float by=getOrigin().y;
    float bs=0;
    
    // Test if the cursor is over the box 

    if (isHoveringX()) {

      bover = true;  

      if (!locked) { 

        stroke(255); 

        fill(153);
      }
    } else {

      stroke(153);

      fill(153);

      bover = false;
    }



    // Draw the box

    //rect(bx, by, bs, bs);

    println("Origin: "+getOrigin());
    println(isHoveringX());



    drawAxes();

    for (Curve c : m_curves) {
      c.draw();
    }
  }
}
