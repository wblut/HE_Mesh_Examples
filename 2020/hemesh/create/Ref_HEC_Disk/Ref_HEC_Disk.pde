import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

ArrayList<HE_Mesh> meshes;
WB_Circle circle;
WB_RandomFactory inSphere, onSphere;
WB_Render render;
WB_Plane XY, YZ, ZX;


void setup() {
  size(1000, 1000, P3D);
  smooth(8); 
  onSphere=new WB_RandomOnSphere();
  inSphere=new WB_RandomInSphere().setRadius(200);
  meshes=new ArrayList<HE_Mesh>();
  for (int i=0; i<36; i++) {
    circle=new WB_Circle(inSphere.nextPoint(), onSphere.nextVector(), random(80, 240));
    HEC_Disk dc=new HEC_Disk().setCircle(circle).setThickness(5.0);
    meshes.add(new HE_Mesh(dc));
  }

  render=new WB_Render(this);

  XY=WB_Plane.XY();
  YZ=WB_Plane.YZ();
  ZX=WB_Plane.ZX();
}

void draw() {
  background(55);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2, 0);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));
  stroke(0);
  render.drawEdges(meshes);
  noStroke();
  render.drawFaces(meshes);
  drawReference();
}

void drawReference() {
  render.drawGizmo(350, 350, 350);
  render.drawGrid(color(180), XY, 700, 700, 14, 14); 
  render.drawGrid(color(180), ZX, 700, 700, 14, 14); 
  render.drawGrid(color(180), YZ, 700, 700, 14, 14);
}

void mouseClicked() {
  meshes=new ArrayList<HE_Mesh>();
  for (int i=0; i<36; i++) {
    circle=new WB_Circle(inSphere.nextPoint(), onSphere.nextVector(), random(80, 240));
    HEC_Disk dc=new HEC_Disk().setCircle(circle).setThickness(5.0);
    meshes.add(new HE_Mesh(dc));
  }
}
