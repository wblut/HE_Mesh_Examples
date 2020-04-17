import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import java.util.List;
HE_Mesh mesh;
WB_Point[] points;
int num;
WB_Render render;
WB_BSPTree3D tree;
float[] meshHues;
float[] pointHues;

void setup() {
  fullScreen(P3D);
  smooth(8);
  colorMode(HSB);
  render=new WB_Render(this);
  mesh=new HE_Mesh(new HEC_Icosahedron().setRadius(200)); 
  mesh.modify(new HEM_Crocodile().setDistance(200));
  mesh.modify(new HEM_Slice().setPlane(0,0,0,0,1,0));
  mesh.triangulate();
  meshHues=new float[mesh.getNumberOfVertices()];
  HE_Vertex v;
  float[] x=new float[mesh.getNumberOfVertices()];
  float[] y=new float[mesh.getNumberOfVertices()];
  float[] z=new float[mesh.getNumberOfVertices()];
  for (int i=0; i<mesh.getNumberOfVertices(); i++) {
    meshHues[i]=random(256.0); 
    v=mesh.getVertexWithIndex(i);
    v.setColor(color(meshHues[i], 255, 255));
    x[i]=v.xf();
    y[i]=v.yf();
    z[i]=v.zf();
  }
  int[] triangles=mesh.getTriangles();


  tree=new WB_BSPTree3D();
  tree.build(mesh);
  num=10000;
  points=new WB_Point[num];
  pointHues=new float[num];
  WB_PointFactory rp=new WB_RandomInSphere().setRadius(350);
  WB_Point p;
  for (int i=0; i<num; i++) {
    do {
      p=rp.nextPoint();
    } while (tree.pointLocation(p)>0);
    points[i]=p;
    pointHues[i]=getValue(p.xf(), p.yf(), p.zf(), x, y, z, meshHues, triangles);
  }
}

void draw() {
  background(55);

 // directionalLight(255, 255, 255, 1, 1, -1);
 // directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  stroke(0);
  render.drawEdges(mesh);
    noStroke();
  colorMode(HSB);
  for (int i=0; i<num; i++) {

    fill(pointHues[i], 255, 255);

    render.drawPoint(points[i], 2);
  }
  colorMode(RGB);

  for (int i=0; i<mesh.getNumberOfVertices(); i++) {
    fill(mesh.getVertexWithIndex(i).getColor());
    render.drawVertex(mesh.getVertexWithIndex(i), 10);
  }
}
