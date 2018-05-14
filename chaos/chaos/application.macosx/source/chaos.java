import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class chaos extends PApplet {


 
PGraphics buf;
int frame = 0;

public void setup() {
  size(600, 600);
  buf = createGraphics(width, height);
  noStroke();
  background(0);
  frameRate(30);
}

public void drawBuf()
{
  buf.beginDraw();
  buf.noStroke();
  buf.fill(255,255,0);
  buf.ellipse(width/2, height/2, 200, 200);
  buf.fill(255,0,0);
  buf.ellipse(width/2 + 100, height/2, 200, 200);
  buf.endDraw();  
}

public PVector inverseLogisticMap(float x, float y)
{
  float xp = x/width;
  float yp = y/height;
  
  for(int i = 0; i < frame; i++)
  {
    xp = 0.5f * (sqrt(1.0f - xp) + 1);
    yp = yp - xp;
    if(yp < 0) yp += 1.0f;
  }
  
  return new PVector(xp*width, yp*height);
}

public PVector mapXY(float x, float y)
{
  float xp = x/width;
  float yp = y/height;
  
    xp = sin(xp*frame);
    yp = cos(yp*frame);
  
  return new PVector(xp*width, yp*height);
}

public int getColor(int x, int y)
{
  PVector vec = mapXY(x,y);
  return buf.get(round(vec.x), round(vec.y));  
}

public void drawFrame()
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

public void draw() {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "chaos" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
