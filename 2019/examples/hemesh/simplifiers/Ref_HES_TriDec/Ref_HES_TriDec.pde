import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

HE_Mesh mesh, oldmesh;

WB_Render render;

void setup() {
  fullScreen(P3D);
  smooth(8);
  createMesh();
  render=new WB_Render(this);
  textAlign(CENTER);
  textSize(16);
}

void draw() {
  background(25);

  translate(width/2, height/2);
  fill(255);
  noStroke();
  text("Click to reduce number of faces by 10%.", 0, 470);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  rotateY(map(mouseX, 0, width, -PI, PI));
  fill(255);
  render.drawFaces(mesh);
  stroke(255, 0, 0, 100);
  //render.drawEdges(oldmesh);
  stroke(0);
  render.drawEdges(mesh);
}


void createMesh() {
  HEC_Creator creator=new HEC_Beethoven().setAxis(0,-1,0).setScale(10);
  mesh=new HE_Mesh(creator);
  oldmesh=mesh.get();
}

void mousePressed() {  
  mesh.selectBackFaces(new WB_Plane(0, 0, 0, 1, 0, 0)).simplify(new HES_TriDec().setFraction(0.9));
}
