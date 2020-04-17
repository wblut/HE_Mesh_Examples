import wblut.nurbs.*;
import wblut.hemesh.*;
import wblut.core.*;
import wblut.geom.*;
import wblut.processing.*;
import wblut.math.*;


WB_Render render;
WB_RBSpline P, Q;
WB_Point[] points, points2;
double[] weights, weights2;
HE_Mesh mesh;

void setup() {
  fullScreen(P3D);
  smooth(8);
  // Several WB_Surface classes are in development. HEC_FromSurface provides
  // a way of generating meshes from them.

  points=new WB_Point[17];
  points2=new WB_Point[17];
  weights=new double[17];
  weights2=new double[17];

  for (int i=0; i<17; i++) {
    points[i]=new WB_Point( -400+i*50, 0, random(50, 250)); 
    points2[i]=new WB_Point( -400+i*50, 400, random(50, 250)); 
    weights[i]=random(1.0);
    weights2[i]=random(1.0);
  }

  P=new WB_RBSpline(points, 4, weights);
  Q=new WB_RBSpline(points2, 3,weights2);

  WB_RBSplineSurface surface=WB_NurbsFactory.getRuledSurface(P, Q);
 // WB_RBSplineSurface surface=WB_NurbsFactory.getSurfaceOfRevolution(P, new WB_Point(0, 0, 0), new WB_Vector(1, 0, 0), PI);
  //WB_RBSplineSurface surface=WB_NurbsFactory.getFullSurfaceOfRevolution(P, new WB_Point(0,0,0),new WB_Vector(1,0,0));
  //WB_RBSplineSurface surface=WB_NurbsFactory.getLineSweep(P, new WB_Point(0,1,0),200);
  HEC_FromSurface creator=new HEC_FromSurface();
  creator.setSurface(surface);//surface can be any implementation of the WB_Surface interface
  creator.setU(21);// steps in U direction
  creator.setV(21);// steps in V direction
  creator.setUWrap(false);// wrap around in U direction
  creator.setVWrap(false);// wrap around in V direction
  mesh=new HE_Mesh(creator); 
  mesh.stats();
  mesh.modify(new HEM_Shell().setThickness(20));
  mesh.subdivide(new HES_CatmullClark(), 2);
  render=new WB_Render(this);
}

void draw() {
  background(55);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  stroke(0);
  render.drawEdges(mesh);
  stroke(255, 0, 0);
  render.drawCurve(P, 21);
  render.drawCurve(Q, 21);
  noStroke();
  render.drawFaces(mesh);
}
