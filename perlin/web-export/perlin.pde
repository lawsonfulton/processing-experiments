PGraphics pg;
PGraphics trails;

int resx = 800;
int resy = 800;

int fade_rate = 20; //0-255

void setup() {
  size(resx, resy);
  pg = createGraphics(resx, resy);
  trails = createGraphics(resx, resy);
  
  trails.beginDraw();
  trails.background(0);
  trails.endDraw();
}

float oldx = width/2;
float oldy = height/2;

float theta = 0.0;
float delta = 0.02;

float rest_length = resx/1.5;
float r = rest_length; //arm length
float noiseScale = 0.005;
float intensity = 1;
void draw() {
  //r = resx/3 - (sin(theta*3) * (resx/3))*0.5;
  float armx = resx/2 + cos(theta) * r;
  float army = resy/2 + sin(theta)* r;
  
  float noiseVal = noise(armx*noiseScale, army*noiseScale);
  r = noiseVal * rest_length * intensity; 
                            
  pg.beginDraw();
  pg.background(0,0,0,0);
  
  pg.strokeWeight(2);
  pg.stroke(0,100,255);
  //pg.line(resx/2, resy/2, armx, army);
  pg.endDraw();
  
  trails.beginDraw();
  trails.noStroke();
  trails.fill(0,0,0,fade_rate);
  trails.rect(0,0,width,height);
  trails.strokeWeight(5);
  trails.stroke(255);
  if(!mousePressed) {
    trails.line(oldx,oldy,armx,army);
  }
  trails.endDraw();
  
  theta += delta;
  
  oldx = armx;
  oldy = army;
  
  image(trails, 0, 0); 
  image(pg, 0, 0);
}

