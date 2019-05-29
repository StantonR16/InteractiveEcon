boolean hitScan(Point src, float x, float y, float size) {
  return src.x > x-size && src.x < x+size && 
    src.y > y-size && src.y < y+size;
}

Curve createVisualGuide(Point p, String name) {
  return createVisualGuide(p,name,mouse());
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

Curve createVisualGuide(Point p, String name, Point p2, color c) {
  Point target = new Point(p.x, p.y);
  Line vg = asStandard(target, p2, c);

  return new Curve(name, vg, true);
}

void printPoint(float x, float y) {
  printf("x: %f, y: %f",x,y);
}

Curve createVisualGuide(Point p, String name, Point p2) {
  return createVisualGuide(p,name,p2,#808080);

  
}


Line asStandard(Point src, Point dest, color c) {
  Point delta = new Point(dest.x-src.x, dest.y-src.y);
  return new Line(src, delta, c);
}



boolean linePoint(Line ln1, Point p) {
  Point orig = ln1.getOrigin();
  Point dest = ln1.getDelta();

  return linePoint(orig.x, orig.y, orig.x+dest.x, orig.y+dest.y, p.x, p.y);
}



// www.jeffreythompson.org/collision-detection/line-point.php
boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, x2, y2);
  float lineLen = dist(x1, y1, x2, y2);
  float tolerance = 0.15;    // higher # = less accurate
  if (d1+d2 >= lineLen-tolerance && d1+d2 <= lineLen+tolerance) {
    return true;
  }
  return false;
}

void debugCoordinates() {
  text("Mouse: " + mouse(), mouseX, mouseY);
}

public  Point mouse() {
  return new Point(mouseX, mouseY);
}

void printf(String s, Object... args) {
  println(String.format(s, args));
}
