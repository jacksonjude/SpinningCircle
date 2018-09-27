float thetaAddSpeed = 1;
final int maxCircles = 40;

void setup()
{
  size(500, 500);
  frameRate(60);
  surface.setResizable(true);
  surface.setAlwaysOnTop(true);
}

float r;
float theta = 0.0;

ArrayList<Circle> circles = new ArrayList<Circle>();

void draw()
{
  thetaAddSpeed = 60.0/frameRate;
  r = (width-(width/5))/2;

  translate(width/2, height/2);
  background(0);

  displayStats();

  theta += thetaAddSpeed;

  if (frameCount % ((int)(Math.random()*50)+20) == 0 && circles.size() < maxCircles)
  {
    addCircle();

    if (circles.size() == maxCircles)
    {
      circles.add(new Circle(0.0, 1, theta));
    }
  }

  drawCircles();
}

void displayStats()
{
  fill(255, 50);
  textSize(width/20);
  textAlign(LEFT);
  text(circles.size(), -width/2 + width/100, -height/2 + height/16);

  fill(255, 50);
  textSize(width/20);
  textAlign(RIGHT);
  text(frameRate, width/2 - width/100, -height/2 + height/16);
}

void drawCircles()
{
  for (int i=0; i < circles.size(); i++)
  {
    Circle circle = circles.get(i);
    circle.addPoint(theta);
    circle.drawCircle();
    //circle.decayTime += 1;
    //if (circle.decayTime >= 5000)
    //{
      //circles.remove(i);
    //}
  }
}

void addCircle()
{
  circles.add(new Circle((float)Math.random()*360, (float)Math.random(), theta));
}

void keyPressed()
{
  if (key == ENTER)
  {
    addCircle();
  }
  else if (keyCode == SHIFT)
  {
    circles = new ArrayList<Circle>();
  }
  else if (key == 'r')
  {
    surface.setSize(width, width);
  }
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

  public int HSBtoRGB(float hue, float saturation, float brightness)
  {
    if (saturation == 0)
      return convert(brightness, brightness, brightness, 0);
    if (saturation < 0 || saturation > 1 || brightness < 0 || brightness > 1)
      throw new IllegalArgumentException();
    hue = hue - (float) Math.floor(hue);
    int i = (int) (6 * hue);
    float f = 6 * hue - i;
    float p = brightness * (1 - saturation);
    float q = brightness * (1 - saturation * f);
    float t = brightness * (1 - saturation * (1 - f));
    switch (i)
    {
    case 0:
      return convert(brightness, t, p, 0);
    case 1:
      return convert(q, brightness, p, 0);
    case 2:
      return convert(p, brightness, t, 0);
    case 3:
      return convert(p, q, brightness, 0);
    case 4:
      return convert(t, p, brightness, 0);
    case 5:
      return convert(brightness, p, q, 0);
    default:
      throw new InternalError("impossible");
    }
  }

  private int convert(float red, float green, float blue, float alpha)
  {
    if (red < 0 || red > 1 || green < 0 || green > 1 || blue < 0 || blue > 1 || alpha < 0 || alpha > 1)
      throw new IllegalArgumentException("Bad RGB values");
    int redval = Math.round(255 * red);
    int greenval = Math.round(255 * green);
    int blueval = Math.round(255 * blue);
    int alphaval = Math.round(255 * alpha);
    return (alphaval << 24) | (redval << 16) | (greenval << 8) | blueval;
  }

  void show()
  {
    int rgb = HSBtoRGB(100-fade / 100, 1, 1);
    float red = (rgb>>16)&0xFF;
    float green = (rgb>>8)&0xFF;
    float blue = rgb&0xFF;

    strokeWeight(ceil(1.0*width/100));
    stroke(red, green, blue, fade);
    point(x, y);
  }
}
