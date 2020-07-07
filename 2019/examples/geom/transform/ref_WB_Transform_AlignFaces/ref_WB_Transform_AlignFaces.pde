import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.processing.*;

HE_Mesh mesh1;
HE_Mesh mesh2;
HE_Mesh latticeMesh2;
HE_Mesh transformedLatticeMesh2;
HE_Vertex v1;
HE_Vertex v2;
WB_CoordinateSystem CS1;
WB_CoordinateSystem CS2;
WB_Render3D render;
void setup() {
  size(800, 800, P3D);
  smooth(8);
  background(55); 
  render=new WB_Render3D(this);
  mesh1=new HE_Mesh(new HEC_Icosahedron().setRadius(100).setCenter(-150, 0, 0));
  mesh2=new HE_Mesh(new HEC_Icosahedron().setRadius(100).setCenter(150, 0, 0));
  latticeMesh2=mesh2.get();
  latticeMesh2.modify(new HEM_Lattice().setWidth(15).setDepth(12));
  create(0,0,0,0);
  textAlign(CENTER);
  textSize(16);
  
}

void create(int fromFace, int fromVertex, int toFace, int toVertex) {
  //Aligns fromFace of mesh1 with toFace of mesh2 in such a way that fromVertex of fromFace ends up in the same direction as toVertex of toFace.
  HE_Face f=mesh1.getFaceWithIndex(fromFace);
  v1=f.getFaceVertices().get(fromVertex);
  CS1=new WB_CoordinateSystem();
  CS1.setOrigin(f.getFaceCenter());
  WB_Vector v=new WB_Vector(f.getFaceCenter(), v1);
  CS1.setXZ(v, f.getFaceNormal());
  
  f=mesh2.getFaceWithIndex(toFace);
  v2=f.getFaceVertices().get(toVertex);
  CS2=new WB_CoordinateSystem();
  CS2.setOrigin(f.getFaceCenter());
  v=new WB_Vector(f.getFaceCenter(),v2);
  CS2.setXZ(v, WB_Vector.mul(f.getFaceNormal(),-1));
 
  WB_Transform3D T=new WB_Transform3D().addFromWorldToCS(CS2).addFromCSToWorld(CS1);
  transformedLatticeMesh2=latticeMesh2.apply(T);
}


void draw() {
  background(50);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2, 0);
  fill(0);
  text("click for random alignment",0,350);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  noStroke();
  fill(255);
  render.drawFaces(mesh1);
  render.drawFaces(latticeMesh2);
  fill(0,255,0);
  render.drawVertex(v1,10);
  render.drawVertex(v2,10);
  stroke(0);
  render.drawEdges(mesh2);
  render.drawEdges(transformedLatticeMesh2);
  drawCS(CS1);
  drawCS(CS2);
  
}


void drawCS(WB_CoordinateSystem CS) {
  pushStyle(); 
  WB_Point origin=CS.getOrigin();
  WB_Vector X=CS.getX();
  WB_Vector Y=CS.getY();
  WB_Vector Z=CS.getZ();
  stroke(0,255,0);
  render.drawVector(origin, X,100);
  stroke(255,0,0);
  render.drawVector(origin, Y,100);
  stroke(0,0,255);
  render.drawVector(origin, Z,100);
  pushMatrix();
  fill(255,0,0);
  noStroke();
  translate(origin.xf(),origin.yf(),origin.zf());
  sphere(6);
  popMatrix();
  popStyle();
}

void mousePressed(){
 create((int)random(mesh1.getNumberOfFaces()),(int)random(3.0),(int)random(mesh2.getNumberOfFaces()),(int)random(3.0)); 
}
