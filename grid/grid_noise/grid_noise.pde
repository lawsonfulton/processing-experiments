PGraphics pg;
PGraphics lines;
PGraphics line_bak;
OpenSimplexNoise noise;



void setup() {
  size(800, 800);
  pg = createGraphics(width, height);

  lines = createGraphics(width + 200 , height);
  line_bak = createGraphics(width + 200, height);
  //copyGraphics(lines, line_bak);
  noise = new OpenSimplexNoise();
  
  lines.beginDraw();
  lines.background(0, 0, 0);
  lines.endDraw();
  smooth(0);
  //blendMode(DIFFERENCE);

  line_bak.beginDraw();
  line_bak.background(0);
  line_bak.endDraw();
}

float normalDistribution(float num, float mu, float sd) {
  float e = 2.71828182845904523536; 
  float ND  =  (1/sqrt(TWO_PI * sd ))*pow (e, (-(sq(num - mu))/(2*sq(sd ))));
  return ND;
}

int frame = 0;
int num_frames = 75;
float noise_scale = 0.02;
float noise_radius = 1.5;

int grid_step = 60;
int buffer = 400;

PVector map_point(float x, float y) {

  //float amplitude = displ_scale * normalDistribution(dist(x, y, mouseX, mouseY) , 0.0, 100.0);
  
  //float amplitude = 50.0;
  //float freq = 1/80.0;
  //float scale = 0.01;
  
  //Tubes
  float amplitude = 50.0;
  float freq = 1/30.0;
  float scale = 0.01;
  
  float dx = amplitude * sin(float(frame) * freq + y * scale);
  float dy = amplitude * sin(float(frame) * freq + x * scale);
  return new PVector(x + dx, y + dy);
}


void draw() {
  lines.beginDraw();
  lines.clear();
  lines.background(0, 0, 0, 10);
 
  //int col = int(255.0f * (0.5f + sin(frame/10.0)/ 2.0));
  int col = 255;
  
  
      
  lines.stroke(col, 255, col);
  lines.strokeWeight(5.2);

  float speed = 0.0;

  //lines.image(line_bak, 0, 0);
  //lines.translate(speed * frame, 0);

  for (int xi = -buffer; xi < width + buffer; xi += grid_step) {
    for (int yi = -buffer; yi < height + buffer; yi += grid_step) {
      //float ns = (float)noise.eval(noise_scale*xi,noise_scale*yi,radius*cos(TWO_PI*t),radius*sin(TWO_PI*t));
      //float col = map(ns,-1,1,0,255);

      PVector v = map_point(xi, yi);
      PVector v1 = map_point(xi + grid_step, yi);
      PVector v2 = map_point(xi, yi + grid_step);
      //lines.line(v.x, v.y, v1.x, v1.y);
      //lines.line(v.x, v.y, v2.x, v2.y);
      //lines.strokeWeight(4.2);
      //lines.point(v.x, v.y);
      float frac = 0.8;
      //lines.noFill();
      //lines.fill(203, 203, 203, 150);
      lines.ellipse(v.x, v.y, grid_step * frac, grid_step * frac);
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


  image(line_bak.get((int)(frame * speed), 0, (int)(frame * speed + width), height), 0, 0);
  //image(lines.get(0, 0, width, height), 0, 0);
  //translate(10, 10);
  //image(lines, 0 * -speed * frame, 0); 
  //image(line_bak, 10, 10); 
  //saveFrame("frames/frame-####.tiff");
  frame++;
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