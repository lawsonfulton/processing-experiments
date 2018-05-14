void setup() {
  size(800, 800);
  smooth(4);
  frameRate(30);
}

float big_rad = 1500;

float osc_scale = 20.0;
int num_circ = 40;
float tot_frames = 500;

void draw() {
  
  //fill(243, 240, 150, 15);
  fill(255);
  rect(0,0, width, height);
  //fill(120, 180, 250);
  fill(0);
  strokeWeight(0.0);
  noStroke();
  
  float t = frameCount / tot_frames * TWO_PI;
  float rad_s = big_rad * lerp(1.0, 1.2, sin(t * 5));
  float small_rad_s = 10.0;
  float x_c = width / 2;
  float y_c = height / 2;
  //ellipse(x_c, y_c, rad, rad);
  
  int repeat = 200;
  for(int j = 0; j < repeat; j++) {
    float c = lerp(abs(sin(t)), 0.0, float(j)/repeat);
    
    float rad = rad_s * c;
    float small_rad = small_rad_s * c;
    float c2 = lerp(1.0, 0.0, float(j)/repeat) * abs(sin(t));
    //fill(120 * c2 + 60.0, 180 * c2+ 60.0, 250 * c2+ 60.0);
    for (int i = 0; i < num_circ; i++) {
  
      float p = lerp(0, TWO_PI, float(i) / num_circ);
  
      float d = rad / 2.0 + sin(p * 20 + t * 10) * osc_scale;
      
      float rot_speed = 0.8 * cos(float(j)/repeat * TWO_PI * cos(t)) ;
      float x = cos(p + t * rot_speed) * d + x_c;
      float y = sin(p + t * rot_speed) * d + y_c;
  
      ellipse(x, y, small_rad, small_rad);
    }
  }
  //println(t);
  //ellipse(x_c, y_c, rad, rad);
}