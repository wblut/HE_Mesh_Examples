import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import java.util.List;

List<WB_Triangle> triangles;
WB_Render render;

void setup() {
  size(1000,1000,P3D);
  smooth(8);

  float[][][] values=new float[51][51][51];
  for (int i = 0; i < 51; i++) {
    for (int j = 0; j < 51; j++) {
      for (int k = 0; k < 51; k++) {
        values[i][j][k]=noise(0.07*i, 0.07*j, 0.07*k);
      }
    }
  }

  WB_IsoSurface creator=new WB_IsoSurface();
  creator.setSize(8, 8, 8);
  creator.setValues(values);

  creator.setIsolevel(.6);
  creator.setInvert(false);
  creator.setBoundary(-200);// value outside grid
  // use creator.clearBoundary() to rest boundary values to "no value".
  // A boundary value of "no value" results in an open mesh
  
  //Gamma controls level of grid snap, 0.0-0.5. Can improve the 
  //quality of the triangles, but can give small changes in topology.
  //For 3D, gamma=0.3 is a good value.
  creator.setGamma(0.3); 
  
  triangles=creator.getTriangles();
  render=new WB_Render(this);
}

void draw() {
  background(55);
  lights();
  translate(width/2, height/2);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  fill(255);
  stroke(0);
  render.drawTriangle(triangles);
}