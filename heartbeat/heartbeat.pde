
 
float maxrate = 120;
float minrate = 60;
float period = 100;

float delta = maxrate - minrate;
void setup() {
  size(640, 360);
  noStroke();
  background(0);
}

void draw() {
  background(0);
  
  float t = millis()/1000.0;
  float rate = sin(t * TWO_PI / period)/2.0 * (delta) + minrate + delta/2.0;
  float rate_i = t*(minrate + 0.25 * t * sin(TWO_PI * t / period) + 0.25 * t);
  fill(255,255,255);
  text("Rate: " + rate, 10, 30); 
  text("Integral: " + rate_i, 10, 60); 

  //float b = sin(rate/60.0 * t * TWO_PI)/2.0 + 0.5;
  float b = sin(rate_i)/2.0 + 0.5;
  fill(200 * b, 0, 0 );
  ellipse(width/2,height/2,100,100);
   
}

//Input time t varies from -x  to x
float pulse(float x)
{
  float result = 0;
  if(abs(x) >= 1)
  {
    return 0.0;
  else
  {
    return exp(1.0/(x*x-1.0)) * exp(1);
  }
}



