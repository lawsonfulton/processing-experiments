PGraphics pg;
PGraphics lines;
PGraphics line_bak;
int frame = 0;

void setup() {
  size(800, 800);
  pg = createGraphics(width, height);

  lines = createGraphics(width + 200 , height);
  line_bak = createGraphics(width + 10000, height);
  //copyGraphics(lines, line_bak);

  lines.beginDraw();
  lines.background(0, 0, 0);
  lines.endDraw();
  smooth(0);
  //blendMode(DIFFERENCE);

  line_bak.beginDraw();
  line_bak.background(0);
  line_bak.endDraw();
}

PGraphics copyGraphics(PGraphics src, PGraphics dest  ) {
  if (dest == null || dest.width != src.width || dest.height != src.height) {
    dest = createGraphics(src.width, src.height);
    dest.beginDraw();
    dest.endDraw();
  }
  src.loadPixels();
  dest.loadPixels();
  arrayCopy(src.pixels, 0, dest.pixels, 0, src.pixels.length);
  dest.updatePixels();
  return dest;
}

int grid_step = 60;
int buffer = 100;

float displ_scale = 1000.0;

float normalDistribution(float num, float mu, float sd) {
  float e = 2.71828182845904523536; 
  float ND  =  (1/sqrt(TWO_PI * sd ))*pow (e, (-(sq(num - mu))/(2*sq(sd ))));
  return ND;
}


PVector map_point(float x, float y) {

  //float amplitude = displ_scale * normalDistribution(dist(x, y, mouseX, mouseY) , 0.0, 100.0);
  float amplitude = 50.0;
  float freq = 1/80.0;
  float scale = 0.1;
  float dx = amplitude * sin(float(frame) * freq + y * scale);
  float dy = amplitude * sin(float(frame) * freq + x * scale);
  return new PVector(x + dx, y + dy);
}


void draw() {
  lines.beginDraw();
  lines.clear();
  lines.background(0, 0, 0, 2);
 
  //int col = int(255.0f * (0.5f + sin(frame/10.0)/ 2.0));
  int col =255;
  lines.stroke(col, 255, col);
  lines.strokeWeight(2.2);

  int speed = 1;

  //lines.image(line_bak, 0, 0);
  //lines.translate(speed * frame, 0);

  for (int xi = -buffer; xi < width + buffer; xi += grid_step) {
    for (int yi = -buffer; yi < height + buffer; yi += grid_step) {

      PVector v = map_point(xi, yi);
      PVector v1 = map_point(xi + grid_step, yi);
      PVector v2 = map_point(xi, yi + grid_step);
      lines.line(v.x, v.y, v1.x, v1.y);
      lines.line(v.x, v.y, v2.x, v2.y);
    }
  }
  lines.endDraw(); 

  //copyGraphics(lines, line_bak);//
  line_bak.beginDraw();
  line_bak.stroke(0,0,0,0);
  line_bak.fill(0,0,0,5);
  //line_bak.rect(speed * frame, 0, speed * frame + width, height);
  //line_bak.background(0, 0, 0, 10);
  line_bak.image(lines, speed * frame, 0, width + 200, height);
  line_bak.endDraw();


  image(line_bak.get(frame * speed, 0, frame * speed + width, height), 0, 0);
  //image(lines.get(0, 0, width, height), 0, 0);
  //translate(10, 10);
  //image(lines, 0 * -speed * frame, 0); 
  //image(line_bak, 10, 10); 
  //saveFrame("frames/frame-####.tiff");
  frame++;
}