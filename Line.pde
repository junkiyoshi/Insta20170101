class Line
{
  PVector[] history;
  
  Line(float x, float y)
  {
    history = new PVector[20];
    for(int i = 0; i < history.length; i++)
    {
      history[i] = new PVector(x, y);
    }
  }
  
  void update(float x, float y)
  {
    for(int i = history.length - 1; i > 0; i--)
    {
      history[i] = history[i - 1].copy();
    }
    history[0] = new PVector(x, y);
  
    for(int i = 0; i < history.length - 1; i++)
    {
      stroke(color(255), 255 - i * 30);
      strokeWeight(10);
      line(history[i].x, history[i].y, history[i + 1].x, history[i + 1].y);
    }
  }
}