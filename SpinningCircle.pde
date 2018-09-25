final float thetaAddSpeed = 1;



void setup()
{
  size(500, 500);
  frameRate(60);

  r = (width-(width/5))/2;
}

float r;
float theta = 0.0;

ArrayList<Circle> circles = new ArrayList<Circle>();

//int multsAdded = 0;

void draw()
{
  translate(width/2, height/2);
  /*if (multsAdded != circles.size())
  {
    multsAdded = circles.size();
    println(multsAdded);
  }*/
  background(0);

  fill(255, 50);
  textSize(25);
  textAlign(LEFT);
  text(circles.size(), -width/2 + 5, -height/2 + 30);

  theta += thetaAddSpeed;

  if (theta % ((int)(Math.random()*300)) == 0 && circles.size() < 40)
  {
    circles.add(new Circle((float)Math.random()*360, (float)Math.random(), theta));
    if (circles.size() == 40)
    {
      circles.add(new Circle(0.0, 1, theta));
    }
  }

  for (int i=0; i < circles.size(); i++)
  {
    Circle circle = circles.get(i);
    circle.addPoint(theta);
    circle.decayTime += 1;
    circle.drawCircle();
    if (circle.decayTime >= 5000)
    {
      //circles.remove(i);
    }
  }
}

void mousePressed()
{
  circles = new ArrayList<Circle>();
}

class Circle
{
  float randomRotation = 0.0;
  float thetaShift = 0.0;
  float randomMult = 0.0;
  int decayTime = 0;
  ArrayList<CirclePoint> circlePoints = new ArrayList<CirclePoint>();

  Circle(float randomRotation, float randomMult, float thetaShift)
  {
    this.randomRotation = randomRotation;
    this.thetaShift = thetaShift;
    this.randomMult = randomMult;
  }

  void addPoint(float currentTheta)
  {
    float x = (r * cos((currentTheta-thetaShift)*3.1415/180.0))*randomMult;
    float y = (r * sin((currentTheta-thetaShift)*3.1415/180.0));
    float xTransformed = (x*cos(randomRotation*3.1415/180.0)) - (y*sin(randomRotation*3.1415/180.0));
    float yTransformed = (y*cos(randomRotation*3.1415/180.0)) + (x*sin(randomRotation*3.1415/180.0));
    circlePoints.add(new CirclePoint(xTransformed, yTransformed, 100.0));
  }

  void drawCircle()
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
    fade -= thetaAddSpeed;
  }

  void show()
  {
    strokeWeight(ceil(1.0*width/100));
    stroke(255, 0, 255, fade);
    point(x, y);
  }
}
