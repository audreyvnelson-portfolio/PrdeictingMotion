/**
  Circle class was meant to have a radius that would be used, but we ended up finding a better solution to
    modify the radius when drawing the circles(good job Audrey!). So for now the Circle class is mainly used 
    to operate as a point class while also having a few methods to help out.
*/
public class Circle
{
  float x; // x coord
  float y; // y coord
  float r; // radius
  
  Circle(float x, float y)
  {
    this.x = x;
    this.y = y;
    r = 0;
  }
  
  /** 
    updatePos is used to follow the 'mama duck' trick to where the Circle(a) will travel half distance to the
      adjacent Circle(b). No return necessary, it updates the current circle.
    */      
  void updatePos(Circle a, Circle b)
  {
    a.x = (a.x + b.x)/2;
    a.y = (a.y + b.y)/2;
  }
 
 
  /** 
    getSpeed is a method that returns the change in position of Circle(a), which is implemented by the distance
       formula. We use this method to help with our mode3 idea.
    */     
  float getSpeed(Circle a, Circle b)
  {
     return sqrt(sq(b.x - a.x) + sq(b.y - a.y));
  }
}
