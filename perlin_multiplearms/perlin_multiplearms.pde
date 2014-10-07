import controlP5.*;
ControlP5 cp5;

PGraphics pg;
PGraphics trails;

int resx = 800;
int resy = 800;
int frame_n = 0;

int n_arms = 10;
int trail_count = 10;
float fade_rate = 0.1;
float pathNoiseScale = 0.005;
float morphNoiseScale = 0.1;
float colourNoiseScale = 0.1;
float intensity = 1;
float speed = 0.02;

float [] oldx = new float[n_arms];
float [] oldy = new float[n_arms];

float [] theta = new float[n_arms];

float [] rest_length = new float[n_arms];
float [] r = new float[n_arms];

float [] armx = new float[n_arms];
float [] army = new float[n_arms];

void setup() {
  size(resx, resy);
  pg = createGraphics(resx, resy);
  trails = createGraphics(resx, resy);
  
  trails.beginDraw();
  trails.background(0);
  trails.endDraw();
  
  noStroke();
  cp5 = new ControlP5(this);
  cp5.addSlider("pathNoiseScale")
     .setPosition(10 ,10)
     .setRange(0,0.01);
  cp5.addSlider("morphNoiseScale")
     .setPosition(10 ,40)
     .setRange(0,1);
  cp5.addSlider("colourNoiseScale")
     .setPosition(10 ,70)
     .setRange(0,1);
  cp5.addSlider("fade_rate")
     .setPosition(10 ,100)
     .setRange(0,0.2);
  cp5.addSlider("speed")
     .setPosition(10 ,130)
     .setRange(0,0.05);
  cp5.addSlider("trail_count")
     .setPosition(10,160)
     .setRange(1,n_arms);

  for(int i = 0; i < n_arms; i++) {
    oldx[i] = resx/2;
    oldy[i] = resy/2;
    
    theta[i] = 2 * PI * (((float)i) / ((float)n_arms));
    
    rest_length[i] = resx/1.5;
    r[i] = rest_length[i]; //arm length
  }
}


void draw() {
  for(int i = 0; i < n_arms; i++) {
    armx[i] = resx/2 + cos(theta[i]) * r[i];
    army[i] = resy/2 + sin(theta[i])* r[i];
  
    float noiseVal = noise(armx[i]*pathNoiseScale, army[i]*pathNoiseScale, theta[0] * morphNoiseScale);
    r[i] = noiseVal * rest_length[i] * intensity; 
  }           
  
  pg.beginDraw();
  pg.background(0,0,0,0);
  
  pg.strokeWeight(2);
  pg.stroke(0,100,255);
  //pg.line(resx/2, resy/2, armx, army);
  pg.endDraw();
  
  trails.beginDraw();
  trails.noStroke();
  trails.fill(0,0,0,fade_rate * 255);
  trails.rect(0,0,width,height);
  trails.strokeWeight(15);
  float r = noise(theta[0] * colourNoiseScale ) * 255;
  float g = noise(theta[0] * colourNoiseScale +1000) * 255;
  float b = noise(theta[0] * colourNoiseScale +2000 ) * 255;
  trails.stroke(r,g,b);
  if (frame_n > 2) {
    for(int i = 0; i < trail_count; i++) {
      trails.line(oldx[i],oldy[i],armx[i],army[i]);
    }
  }
  trails.endDraw();
  
  for(int i = 0; i < n_arms; i++) {
    theta[i] += speed;
  
    oldx[i] = armx[i];
    oldy[i] = army[i];
  }
  
  frame_n++;
  
  image(trails, 0, 0); 
  image(pg, 0, 0);
}
