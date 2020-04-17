import wblut.geom.*;
import wblut.processing.*;

WB_Point p;
WB_Line L;
WB_Point closestPoint;
WB_Render3D render;

void setup() {
  size(1000, 1000, P3D);
  smooth(8);
  background(55); 
  create(); 
  render=new WB_Render3D(this);
  strokeWeight(2);
}

void create() {
  L=new WB_Line(new WB_Point(random(-200, 200), random(-200, 200), random(-200, 200)), new WB_Vector(random(-200, 200), random(-200, 200), random(-200, 200)));
  p=new WB_Point(random(-200, 200), random(-200, 200), random(-200, 200));
  closestPoint=WB_GeometryOp.getClosestPoint3D(p,L);
}

void draw() {
  background(55); 
  translate(width/2,height/2);
  rotateX(mouseY*1.0/height*TWO_PI-PI);
  rotateY(mouseX*1.0/width*TWO_PI-PI);
  stroke(0);
  
  render.drawLine(L, 4000);
  render.drawPoint(p, 20);
   stroke(255,0,0);
  
   render.drawSegment(p,closestPoint);
    render.drawPoint(closestPoint, 10);
  
}

void mousePressed() {
 create();
}
