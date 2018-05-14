
 
PGraphics buf;
int frame = 0;

void setup() {
  size(600, 600);
  buf = createGraphics(width, height);
  noStroke();
  background(0);
  frameRate(30);
}

void drawBuf()
{
  buf.beginDraw();
  buf.noStroke();
  buf.fill(255,255,0);
  buf.ellipse(width/2, height/2, 200, 200);
  buf.fill(255,0,0);
  buf.ellipse(width/2 + 100, height/2, 200, 200);
  buf.endDraw();  
}

PVector inverseLogisticMap(float x, float y)
{
  float xp = x/width;
  float yp = y/height;
  
  for(int i = 0; i < frame; i++)
  {
    xp = 0.5 * (sqrt(1.0 - xp) + 1);
    yp = yp - xp;
    if(yp < 0) yp += 1.0;
  }
  
  return new PVector(xp*width, yp*height);
}

PVector mapXY(float x, float y)
{
  float xp = x/width;
  float yp = y/height;
  
    xp = sin(xp*frame);
    yp = cos(yp*frame);
  
  return new PVector(xp*width, yp*height);
}

color getColor(int x, int y)
{
  PVector vec = mapXY(x,y);
  return buf.get(round(vec.x), round(vec.y));  
}

void drawFrame()
{
  loadPixels();
  for(int x = 0; x < width; x++)
  {
    for(int y = 0; y < height; y++)
    {
      int index = y*width+x;
      pixels[index] = getColor(x, y);
    } 
  }
  updatePixels();  
}

void draw() {
  background(0);
  drawBuf();
  //image(buf,0,0);

  drawFrame(); 

  frame++;
}
//
//  float t = millis()/1000.0;
//  float rate = sin(t * TWO_PI / period)/2.0 * (delta) + minrate + delta/2.0;
//  float rate_i = t*(minrate + 0.25 * t * sin(TWO_PI * t / period) + 0.25 * t);
//  fill(255,255,255);
//  text("Rate: " + rate, 10, 30); 
//  text("Integral: " + rate_i, 10, 60); 
//
//  //float b = sin(rate/60.0 * t * TWO_PI)/2.0 + 0.5;
//  float b = sin(rate_i)/2.0 + 0.5;
//  fill(200 * b, 0, 0 );
//  ellipse(width/2,height/2,100,100);
