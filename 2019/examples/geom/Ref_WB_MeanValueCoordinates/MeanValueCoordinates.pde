
static float EPSILON=0.0001;

static float getValue(float px, float py, float pz, float[] x, float[] y, float[] z, float[] values, int[] triangles) {


  int num =x.length;
  assert(y.length==num);
  assert(z.length==num);
  assert(values.length==num);

  float[] d=new float[num];
  float[] ux=new float[num];
  float[] uy=new float[num];
  float[] uz=new float[num];

  for (int i = 0; i < num; i++) {
    ux[i]=x[i]-px;
    uy[i]=y[i]-py;
    uz[i]=z[i]-pz;
    d[i]=sqrt(ux[i]*ux[i]+uy[i]*uy[i]+uz[i]*uz[i]);  
    if (d[i]<EPSILON) return values[i];
    ux[i]/=d[i];
    uy[i]/=d[i];
    uz[i]/=d[i];
  }

  int i1, i2, i3;
  float l1, l2, l3, t1, t2, t3, h, w1, w2, w3, c1, c2, c3, s1, s2, s3, det;



  float totalF=0.0;
  float totalW=0.0;

  for (int i = 0; i < triangles.length; i += 3) {
    i1 = triangles[i];
    i2 = triangles[i + 1];
    i3 = triangles[i + 2];
    l1=dist(ux[i2], uy[i2], uz[i2], ux[i3], uy[i3], uz[i3]);
    if (l1<EPSILON) continue;
    l2=dist(ux[i1], uy[i1], uz[i1], ux[i3], uy[i3], uz[i3]);
    if (l2<EPSILON) continue;
    l3=dist(ux[i2], uy[i2], uz[i2], ux[i1], uy[i1], uz[i1]);
    if (l3<EPSILON) continue;
    t1 = 2.0 * asin(0.5 * l1);
    t2 = 2.0 * asin(0.5 * l2);
    t3 = 2.0 * asin(0.5 * l3);
    h = 0.5 * (t1 + t2 + t3);
    if (abs(PI-h)<EPSILON) {
      w1 = sin(t1) * d[i3] * d[i2];
      w2 = sin(t2) * d[i1] * d[i3];
      w3 = sin(t3) * d[i2] * d[i1];
      return (w1 * values[i1] + w2 * values[i2] + w3 * values[i3]) / (w1 + w2 + w3);
    }
    det=orient3D(x[i1], y[i1], z[i1], x[i2], y[i2], z[i2], x[i3], y[i3], z[i3], px, py, pz);
    c1 = min(max(2 * sin(h) * sin(h - t1) / sin(t2) / sin(t3) - 1.0, -1.0), 1.0);
    s1 = det * sqrt(1.0 - c1 * c1);
    if (abs(s1)<EPSILON)
      continue;
    c2 = min(max(2 * sin(h) * sin(h - t2) / sin(t3) / sin(t1) - 1.0, -1.0), 1.0);
    ;
    s2 = det * sqrt(1.0 - c2 * c2);
    if (abs(s2)<EPSILON)
      continue;
    c3 = min(max(2 * sin(h) * sin(h - t3) / sin(t1) / sin(t2) - 1.0, -1.0), 1.0);
    ;
    s3 = det * sqrt(1.0 - c3 * c3);
    if (abs(s3)<EPSILON)
      continue;
    w1 = (t1 - c2 * t3 - c3 * t2) / (d[i1] * sin(t3) * s2);
    w2 = (t2 - c3 * t1 - c1 * t3) / (d[i2] * sin(t1) * s3);
    w3 = (t3 - c1 * t2 - c2 * t1) / (d[i3] * sin(t2) * s1);
    totalF+=w1 * values[i1] + w2 * values[i2] + w3 * values[i3];
    totalW+=w1 + w2 + w3;
  }

  return totalF/totalW;
}



static float orient3D(float ax, float ay, float az, float bx, float by, float bz, float cx, float cy, float cz, float x, float y, float z) {

  final double adx = ax - x, bdx = bx - x, cdx = cx-x;
  final double ady = ay-y, bdy = by-y, cdy = cy-y;
  double adz = az-z, bdz = bz-z, cdz=cz-z;
  double adxbdy = adx * bdy;
  double adybdx = ady * bdx;
  double adxcdy = adx * cdy;
  double adycdx = ady * cdx;
  double bdxcdy = bdx * cdy;
  double bdycdx = bdy * cdx;
  final double m1 = adxbdy - adybdx;
  final double m2 = adxcdy - adycdx;
  final double m3 = bdxcdy - bdycdx;
  final double det = m1 * cdz - m2 * bdz + m3 * adz;
  if (adxbdy < 0) {
    adxbdy = -adxbdy;
  }
  if (adybdx < 0) {
    adybdx = -adybdx;
  }
  if (adxcdy < 0) {
    adxcdy = -adxcdy;
  }
  if (adycdx < 0) {
    adycdx = -adycdx;
  }
  if (bdxcdy < 0) {
    bdxcdy = -bdxcdy;
  }
  if (bdycdx < 0) {
    bdycdx = -bdycdx;
  }
  if (adz < 0) {
    adz = -adz;
  }
  if (bdz < 0) {
    bdz = -bdz;
  }
  if (cdz < 0) {
    cdz = -cdz;
  }

  return det > 0 ? 1 : det == 0 ? 0 : -1;
}
