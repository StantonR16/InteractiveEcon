Graph g_graph;

void setup() {
  frameRate(144);
  //size(1536,864);
  //surface.setResizable(true);
  size(800, 800);
  //rectMode(CENTER);
  g_graph = new Graph();
}



void draw() {
  background(0);
  g_graph.draw();
}
