PGraphics pg;
PGraphics trails;

int resx = 500;
int resy = 500;

int fade_rate = 50; //0-255

void setup() {
  size(resx, resy);
  pg = createGraphics(resx, resy);
  trails = createGraphics(resx, resy);
  
  trails.beginDraw();
  trails.background(0);
  trails.endDraw();
}

int oldx = width/2;
int oldy = height/2;

void draw() {
  pg.beginDraw();
  pg.background(0,0,0,0);
  pg.fill(0,100,255,150);
  pg.noStroke();
  pg.ellipse(mouseX, mouseY, 20, 20);
  pg.endDraw();
  
  trails.beginDraw();
  trails.noStroke();
  trails.fill(0,0,0,fade_rate);
  trails.rect(0,0,width,height);
  trails.strokeWeight(10);
  trails.stroke(255);
  if(!mousePressed) {
    trails.line(oldx,oldy,mouseX,mouseY);
  }
  trails.endDraw();
  
  oldx = mouseX;
  oldy = mouseY;
  
  image(trails, 0, 0); 
  image(pg, 0, 0);
}
