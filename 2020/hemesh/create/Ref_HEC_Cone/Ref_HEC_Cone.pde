import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.nurbs.*;
import wblut.processing.*;
import wblut.math.*;

HE_Mesh mesh;
WB_Render render;
WB_Plane XY,YZ,ZX;
void setup() {
  size(1000, 1000, P3D);
  smooth(8);
  HEC_Cone creator=new HEC_Cone();
  println(creator.getParameterNames());
  creator.setRadius(200).setHeight(400); 
  creator.setFacets(7).setSteps(5).setCenter(0,0,-100);
  creator.setCap(true);
  XY=WB_Plane.XY();
  YZ=WB_Plane.YZ();
  ZX=WB_Plane.ZX();
  mesh=new HE_Mesh(creator); 
  HET_Diagnosis.validate(mesh);
  render=new WB_Render(this);
}

void draw() {
  background(55);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2,0);
  rotateY(map(mouseX,0,width,-PI,PI));
  rotateX(map(mouseY,0,height,PI,-PI));
  stroke(0);
  render.drawEdges(mesh);
  noStroke();
  render.drawFaces(mesh);
  drawReference(); 

}

void drawReference(){
  render.drawGizmo(250,250,350);
  render.drawGrid(color(180),XY,500,500,10,10); 
  render.drawGrid(color(180),ZX,700,500,14,10); 
  render.drawGrid(color(180),YZ,700,500,14,10); 
}
