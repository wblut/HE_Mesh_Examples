import wblut.processing.*;
import wblut.hemesh.*;
import wblut.geom.*;
import wblut.math.*;
import java.util.List;

WB_GeometryFactory gf=new WB_GeometryFactory();
WB_Render3D render;
List<WB_Polygon> text;
WB_AABB AABB;
HE_Mesh mesh;

void setup() {
  fullScreen(P3D);
  smooth(16);
  noCursor();
  render=new WB_Render3D(this);
  // http://osp.kitchen/foundry/belgica-belgika/
  // License: http://scripts.sil.org/OFL
  text=gf.createTextWithOpenTypeFont("where are WE GOING", sketchPath("Belgika-5th.otf"), 0, 100.0, 0.5);//text; font; style: REGULAR:0, BOLD:1, ITALIC:2, BOLD-ITALIC:3 ; font size; flatness
   //also createTextWithTTFFont
  //     createTextWithType1Font (untested)
  
  HEC_Polygon creator=new HEC_Polygon();
  creator.setPolygon(text);//alternatively polygon can be a WB_Polygon2D
  creator.setThickness(50);// thickness 0 creates a surface
  mesh=new HE_Mesh(creator); 
 mesh.moveToSelf(0,0,0);


}

void draw() {
  background(0);
  translate(width/2, height/2);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));

  fill(255);
  noStroke();
  render.drawFaces(mesh);

}
