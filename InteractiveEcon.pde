Graph g_graph;

void setup() {
  frameRate(144);
  //size(1536,864);
  //surface.setResizable(true);
  size(800, 800);
  //rectMode(CENTER);
  g_graph = new Graph();
  g_graph.addSupply();
  g_graph.addSupplyTax();
  g_graph.addDemand();
}

void keyPressed() {
  if (keyCode == LEFT)
    g_graph.increaseTax();
if (keyCode == RIGHT)
    g_graph.decreaseTax();
}


void draw() {
  background(0);
  g_graph.draw();
  debugCoordinates();
}
