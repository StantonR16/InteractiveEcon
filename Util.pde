boolean hitScan(Point src, float x, float y, float size) {
  return src.x > x-size && src.x < x+size && 
    src.y > y-size && src.y < y+size;
}
boolean hitScan_X(Point src, float x, float y, float size,float thicc) {
  return src.x > x-size && src.x < x+size && 
    src.y > y-thicc && src.y < y+thicc;
}
boolean isHovering(float x, float y, float size) {
  return hitScan(mouse(),x,y,size);
}
boolean isHovering_X(float x, float y, float size,float thicc) {
  return hitScan_X(mouse(),x,y,size,thicc);
}

boolean isHovering(Point p, float size) {
  return isHovering(p.x, p.y, size);
}



public  Point mouse() {
  return new Point(mouseX, mouseY);
}

void box(float x, float y, float s) {
  rect(x,y,s,s);
}
