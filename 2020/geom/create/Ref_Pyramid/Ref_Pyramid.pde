import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.nurbs.*;
import wblut.processing.*;
import wblut.math.*;

WB_Render3D render;
WB_SimpleMesh smesh;
HE_Mesh mesh, grid;
 WB_DipyramidFactory pf;
 double[] offset;
 WB_Point[] points;
void setup() {
  fullScreen(P3D);
  smooth(8);
  noCursor();
  render=new WB_Render3D(this);
  pf=new WB_DipyramidFactory();
  points =new WB_Point[24];
  offset=new double[48];
  for (int i=0; i<24; i++) {
    float radius=random(150,500);
    points[i]=new WB_Point(radius*cos(radians(15*i)), radius*sin(radians(15*i)));
  }
  
  for (int i=0; i<48; i++) {
    offset[i]=(i>=24)?radians(-50):radians(random(20,45));
  }
  pf.setPoints(points);
  smesh=pf.createDipyramidWithHeightAndAngle(500,50,offset);
  mesh=new HE_Mesh(smesh);
  grid=new HEC_Disk().setRadius(720.0).setFacets(256).setThickness(0).setCenter(0,0,-25).create();
 
//mesh.smooth(2);
}

void draw(){
  background(25);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2-100);
  scale(0.8);
 
  rotateX(radians(60));
   rotateZ(map(mouseX, 0, width, -PI, PI));
  noStroke();
  render.drawFaces(mesh);
  render.drawFaces(grid);
  stroke(0);
  render.drawEdges(mesh);
  render.drawEdges(grid);
 
  //smesh=pf.createPyramidWithHeightAndOffset(300.0,offset);
  
}

void mousePressed(){
  for (int i=0; i<24; i++) {
    float radius=random(150,500);
    points[i]=new WB_Point(radius*cos(radians(15*i)), radius*sin(radians(15*i)));
  }
  
  for (int i=0; i<48; i++) {
    offset[i]=(i>=24)?radians(-50):radians(random(20,45));
  }
  pf.setPoints(points);
  smesh=pf.createDipyramidWithHeightAndAngle(500,50,offset);
  mesh=new HE_Mesh(smesh);
  
}
