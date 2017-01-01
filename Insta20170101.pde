import de.voidplus.leapmotion.*;

import java.util.*;
import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing box2d;
// LeapMotion leap;

ArrayList<Circle> circles;
Box box;
Line line;
float size;

void setup()
{
  size(720, 720);
  //fullScreen();
  background(0);
  frameRate(30);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -30);
  
  // leap = new LeapMotion(this);
  
  circles = new ArrayList<Circle>();
  size = 50;
  float div = width / size;
  for(int x = 0; x < div; x++)
  {
    for(int y = 0; y < div; y++)
    {
      circles.add(new Circle(x * size + size / 2, y * size + size / 2, size));
    }
  }
  
  box = new Box();
  line = new Line(width / 2, height / 2);
}

void draw()
{
  background(0);
  box2d.step();
  
  int removeCount = 0;
  Iterator<Circle> it = circles.iterator();
  while(it.hasNext())
  {
    Circle c = it.next();
    c.display();
    
    if(c.idDead())
    {
      it.remove();
      removeCount += 1;
    }
  }
  
  for(int i = 0; i < removeCount * 1.1; i += 1)
  {
    circles.add(new Circle(random(width), random(-width + size, size), size));
  }
  
  if(frameCount % 300 == 1)
  {
    Heart();
  }
  
  /*
  for(Hand h : leap.getHands())
  {
    for(Finger f : h.getFingers())
    {
      if(f.getType() == 1)
      {
        line.update(f.getPosition().x, f.getPosition().y);
        judgement(f.getPosition().x, f.getPosition().y);
        println("line is update");
      }
    }      
  }
  */
  
  println(frameCount);
  /*
  saveFrame("screen-#####.png");
  if(frameCount > 3600)
  {
     exit();
  } 
  */
}

void mouseMoved()
{
  /*
  line.update(mouseX, mouseY);
  judgement(mouseX, mouseY);
  */
}

void Heart()
{
  float power = random(10, 20);
  float w = width / 2;
  float h = height / 2;
  
  float start = random(power);
  for(float r = start; r < power; r += 0.5)
  {
    for(int i = 0; i < 360; i+= 1)
    {
      float x = w + r * (16 * sin(radians(i)) * sin(radians(i)) * sin(radians(i)));
      float y = h + (-1) * r * (13 * cos(radians(i)) - 5 * cos(radians(2 * i)) - 2 * cos(radians(3 * i)) - cos(radians(4 * i)));  
      
      judgement(x, y);
    }
  }
}

void Circle()
{
  float power = random(100, 300);
  float w = width / 2;
  float h = height / 5 * 3;
  
  for(int i = 0; i < 360; i+= 1)
  {
    float x = w + power * cos(radians(i));
    float y = h + power * sin(radians(i));  
    
    judgement(x, y);
  }
}

void judgement(float x, float y)
{
  Iterator<Circle> it = circles.iterator();
  while(it.hasNext())
  {
    Circle c = it.next();
    c.killCircle(x, y);
  }
}