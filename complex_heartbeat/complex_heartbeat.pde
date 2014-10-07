

float maxrate = 120;
float minrate = 60;
float period = 1.0;

int old_time = 0;
float delta = maxrate - minrate;

float t = 0;

void setup() {
  size(640, 360);
  noStroke();
  background(0);
}

void draw() {
  background(0);
  
  int new_time = millis();
  period += 0.001;
  float dt  = (new_time - old_time) / 1000.0 * period;
   t += dt;
   
   
  float d = wave(t);
  
  fill(200 * d, 0, 0 );
  ellipse(width/2,height/2,100,100);
  
  fill(255,255,255);
  plot(make_periodic(t));
  
  text(t,10,30);
  
  old_time = new_time;
}

//Input time t varies from -x  to x
float pulse(float t)
{ 
  float x = 2*t;

  if (abs(x) >= 1)
  {
    return 0.0;
  }
  else
  {
    return exp(1.0/(x*x-1.0)) * exp(1);
  }
}


float make_periodic(float t)
{
  if (t < -1)
  {
    return -((-t + 1) % 2 - 1);
  }
  else
  {
    return (t + 1) % 2 - 1;
  }
}

float wave(float t)
{
  float x = make_periodic(t); //t*2 = 60 bpm
  
  return pulse(x);
}

void plot(float t)
{
  int limit = round((t + 1.0)/2.0*width);
  ellipse(limit, height, 10, 10);
  
  for (int i = 0; i < limit; i++)
  {
    float x = 2* i/(float)width - 1;
    float y = wave(x * 1);
    //println(y);
    int j = round(height - height * y);

    ellipse(i, j, 2, 2);
  }
}

