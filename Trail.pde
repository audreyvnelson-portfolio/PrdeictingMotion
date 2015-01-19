public class Trail
{ 
  private final int size = 30; // Just in case we want more circles
  Circle[] circleArr = new Circle[size]; // Will operate as a queue
  Circle[] averageArr = new Circle[3];
  Circle[] predictArr = new Circle[30];
  
  /**
    This method is used to implement the 'mama duck' procedure, it is meant to replace push
    but also uses the method as an advantage to creating a new circle then shifting it. The 
    updatePos method will do the math from the Circle class to creat the circle's new origin.
    */
  void drag(float x, float y)
  {
     push(x,y);
     // Size-2 because the newly added circle should not be updated
     for(int i = (size-2); i >= 0; i--)
     {
         circleArr[i].updatePos(circleArr[i], circleArr[i+1]);
     }
 
  }
 
  /**
    The new circle will be pushed into the end of the array, this will follow the queue
      procedure that will result in the least recent element to go out of the array. We
      choose to use a primitive data structure and then shift the array so there would
      be no need to import a queue or build one.
    */
  void push(float x, float y)
  {
    Circle p = new Circle(x, y);
    for(int i = 1; i < size; i++)
    {
      circleArr[i-1] = circleArr[i];
    }
    circleArr[size-1] = p;
  } 
  
  /**
    This method is used simply to show the new locations of the circles. A white circle is
      drawn to keep the illusion of there being separate circles instead of all being 
      combined.
    */
  void show()
  {
    for(int i = 0; i < size; i++)
    {
      if(circleArr[i] != null)
      {
         stroke(white); fill(white);
         ellipse(circleArr[i].x, circleArr[i].y, i*2+8, i*2+8);
         stroke(black);
         ellipse(circleArr[i].x, circleArr[i].y, i*2, i*2); 
      }
    }
  }
  
  
  /**
    This method is our EXTRA CREDIT. Its primary function is to show how fast
      the mouse pointer is moving by the opacity of the circle. The darker the circle, the
      higher the change in position, and the main circle can maintain its white color while
      static. We used the distance formula to apply to the opacity of the color. This method
      is compatible with both drag and push. 
    */
  void mode4()
  {
    for(int i = 1; i < size; i++)
    {
      if(circleArr[i] != null)
      {
         stroke(white); fill(white);
         ellipse(circleArr[i].x, circleArr[i].y, i*2+5, i*2+5);
         stroke(black); fill(black, circleArr[i].getSpeed(circleArr[i-1], circleArr[i]));
         ellipse(circleArr[i].x, circleArr[i].y, i*2, i*2);
        
         // Creating lines that will have lines that link
         stroke(circleArr[i].getSpeed(circleArr[i-1], circleArr[i]));
         strokeWeight(2);
         line(circleArr[i].x, circleArr[i].y, circleArr[i-1].x, circleArr[i-1].y);
      }
    }
  }
  
  /**
    This method is the one we came up with ourselves. Its primary function is to show how fast
      the mouse pointer is moving by the opacity of the circle. The darker the circle, the
      higher the change in position, then the stroke weight of the cirlce is determined by the
      average acceleration of all the circles(which the other 29 are hidden). We hid the other
      circles to keep a simple view for the user as well as a tail that shows previous locations.
      We used the distance formula to determine the speed that is applied to the opacity of the color.  
      The push() method is still used to maintain the other locations of the circle.
    */
  void mode3()
  {
    float totesSize = 0;
    for(int i = 1; i < size; i++)
    {
         stroke(black);
         if(circleArr[i]  != null && circleArr[i-1] != null)
         {
           strokeWeight(i/2);
           line(circleArr[i].x, circleArr[i].y, circleArr[i-1].x, circleArr[i-1].y);
           totesSize += circleArr[i].getSpeed(circleArr[i-1], circleArr[i]);
         }
    }
    stroke(red); strokeWeight(2*totesSize/sq(size));
    fill(black, 2.5 * (circleArr[size-2].getSpeed(circleArr[size-1], circleArr[size-2])));
    ellipse(circleArr[size-1].x, circleArr[size-1].y, (size-1)*3, (size-1)*3);
  }
  
  void getAverages(){
    float x = 0;
    float y = 0;
    for(int j = 0; j<3; j++){
     for(int i = (j*10); i<(j*10+10); i++){
       if(circleArr[i]!=null){
         x += circleArr[i].x;
         y += circleArr[i].y;
       }
     } 
     averageArr[j] = new Circle(x/10,y/10);
     x = 0; y = 0;
    }
  }
  
  void drawAverages(){
     for(int i = 0; i<3; i++){
        stroke(green);
         ellipse(averageArr[i].x, averageArr[i].y, 10, 10);  
     }
  }
  
  void predict(){
    //Circle P0 = averageArr[1];
    //Circle G = averageArr[0] - 2*averageArr[1] + averageArr[2];
    //Circle V0 = (averageArr[2] - averageArr[0])/2;
    float t;
    float x; float y;
    for(int i=0; i<30; i++){
       t = 0.55 + (i/(float)10);
       //t = 0.55 + i;
       x = (averageArr[2].x + (t)*((averageArr[0].x - (4 * averageArr[1].x) + (3* averageArr[2].x))/2) + ((1/(float)2)*sq(t)*(averageArr[0].x - 2*averageArr[1].x + averageArr[2].x)));
       y = (averageArr[2].y + (t)*((averageArr[0].y - (4 * averageArr[1].y) + (3* averageArr[2].y))/2) + ((1/(float)2)*sq(t)*(averageArr[0].y - 2*averageArr[1].y + averageArr[2].y)));
       
      predictArr[i] = new Circle(x,y);
    }
  }
  
  void drawPrediction(){
    for(int i = 1; i<30; i++){
        stroke(black);
        //strokeWeight(1);
        noStroke();
        fill(black, 200/i);
         ellipse(predictArr[i].x, predictArr[i].y, 5*i, 5*i); 
        line(predictArr[i-1].x, predictArr[i-1].y, predictArr[i].x, predictArr[i].y); 
     }
  }
}
