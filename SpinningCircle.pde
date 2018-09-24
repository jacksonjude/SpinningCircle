void setup()
{
  size(500, 500);
  frameRate(200);
}

float r = 200;
float theta = 0.0;

ArrayList<float[]> circleMultipliers = new ArrayList<float[]>();
ArrayList<CirclePoint> circlePoints = new ArrayList<CirclePoint>();

void draw()
{
  background(0);

  theta += 1;

  if (theta % ((int)(Math.random()*300)) == 0 && circleMultipliers.size() < 25)
  {
    circleMultipliers.add(new float[]{(float)Math.random(), (float)Math.random(), theta, 0.0});
  }

  for (int i=0; i < circleMultipliers.size(); i++)
  {
    addCirclePoint(circleMultipliers.get(i)[0], circleMultipliers.get(i)[1], circleMultipliers.get(i)[2]);
    circleMultipliers.get(i)[3] += 1;
    if (circleMultipliers.get(i)[3] >= 1000)
    {
      //circleMultipliers.remove(i);
    }
  }
  drawCirclePoints();
}

void addCirclePoint(float xMult, float yMult, float thetaShift)
{
  circlePoints.add(new CirclePoint(width/2 + (r * cos((theta-thetaShift)*3.1415/180.0)*xMult), height/2 + (r * sin((theta-thetaShift)*3.1415/180.0) * yMult), 100.0));
}

void drawCirclePoints()
{
  for (int i=0; i < circlePoints.size(); i++)
  {
      CirclePoint point = circlePoints.get(i);
      point.fadeMore();
      point.show();
      if (point.fade <= 0.0)
      {
        circlePoints.remove(i);
      }
  }
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
    strokeWeight(5);
    stroke(255, 0, 255, fade);
    point(x, y);
  }
}
