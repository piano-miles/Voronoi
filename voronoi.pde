int particles = 50;
float mindist = 0;
int[] x = new int[particles];
int[] y = new int[particles];
int[] dx = new int[particles];
int[] dy = new int[particles];
int a = 0;

void setup() {
  size(1440, 850);
  smooth();
  for (int i=0; i<particles; i++) {
    x[i] = round(random(width));
    y[i] = round(random(height));
    dx[i] = 10;
    dy[i] = 0;
  }
}

void draw() {
  a += 1;
  loadPixels();
  for (int i=0; i<width; i+=2) {
    for (int j=0; j<height; j+=2) {
      mindist = width*1.5;
      for (int p=0; p<particles; p++) {
        if (dist(x[p], y[p], i, j) < mindist) {
          mindist = dist(x[p], y[p], i, j);
        }
        if (dist(x[p]+width, y[p], i, j) < mindist) {
          mindist = dist(x[p]+width, y[p], i, j);
        }
        if (dist(x[p]-width, y[p], i, j) < mindist) {
          mindist = dist(x[p]-width, y[p], i, j);
        }
      }
      pixels[i+(j*width)] = color(mindist);
      pixels[(i+1)+(j*width)] = color(mindist);
      pixels[i+((j+1)*width)] = color(mindist);
      pixels[(i+1)+((j+1)*width)] = color(mindist);
    }
  }
  for (int p=0; p<particles; p++) {
    x[p] += dx[p];
    y[p] += dy[p];
    x[p] = x[p] % width;
    y[p] = y[p] % height;
  }
  updatePixels();
  save("Voronoi" + str(a) + ".png");
  if(a>width/10){
    exit();
  }
}
