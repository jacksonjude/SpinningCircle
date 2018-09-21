void setup()
{
  size(300, 300);
}

float r = 50.0;
float theta = 0.0;

ArrayList<CirclePoint> circlePoints = new ArrayList<CirclePoint>();

void draw()
{
  theta += 1;
}

class CirclePoint
{
  float fade = 0.0;
  float x = 0.0;
  float y = 0.0;
  
  CirclePoint(float x, float y, float fade)
  {
    this.x = x;
    this.y = y;
    this.fade = fade;
  }
  
  void fadeMore()
  {
    fade -= 1.0;
  }
  
  void show()
  {
    point(width/2 + r * cos(theta*3.1415/180.0), height/2 + r * sin(theta*3.1415/180.0));
  }
}
