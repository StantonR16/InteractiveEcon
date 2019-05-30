Graph g_graph;
boolean g_isAuto;

void setup() {
  frameRate(144);
  //size(1536,864);
  //surface.setResizable(true);
  size(700, 500);
  //rectMode(CENTER);
  g_graph = new Graph();
  g_graph.addSupply();
  g_graph.addSupplyTax();
  g_graph.addDemand();
  g_isAuto = true;
}

void keyPressed() {
  if (keyCode == LEFT)
    g_graph.increaseTax();
  if (keyCode == RIGHT)
    g_graph.decreaseTax();
if (keyCode == TAB) {
  g_isAuto = !g_isAuto;
  printf("Auto: %b", g_isAuto);
}
}




void draw() {
  background(0);
  if (g_isAuto) {
    g_graph.changeTax();
  }
  g_graph.draw();
  // debugCoordinates();
}
