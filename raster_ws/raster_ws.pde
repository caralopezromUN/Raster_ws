import frames.timing.*;
import frames.primitives.*;
import frames.processing.*;

// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = false;
boolean punto1 = false;
boolean punto2 = false;
boolean punto3 = false;
// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(500,500, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();

  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it :)
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    public void execute() {
      spin();
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow( 2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.coordinatesOf converts from world to frame
  // here we convert v1 to illustrate the idea
  
  if (debug) {
    pushStyle();
    stroke(255, 255, 0);
    point(round(frame.coordinatesOf(v1).x()), round(frame.coordinatesOf(v1).y()));
    popStyle();
  }
  if(punto1){
  pushStyle();
      noStroke();
    fill(255, 255, 0);
  int sizeGrid = (int) pow(2,n-1);
  for(int  i = -sizeGrid ; i < sizeGrid ; i++ ){
    for(int j = -sizeGrid; j < sizeGrid; j++){
      //println("i: " + i + ", j: " + j);
      if(verifiIntoTriangle(i,j) )
          rect(i, j, 1 , 1);
    }
  }
   popStyle();
  }
    if(punto2){
  pushStyle();
  stroke(255, 255, 0, 125);
  int sizeGrid = (int) pow(2,n-1);
  for(int  i = -sizeGrid ; i < sizeGrid; i++ ){
    for(int j = -sizeGrid; j < sizeGrid; j++){
      if (verifiIntoTriangle2(i,j) )
              rect(i,j,1,1);
              
    }
    
  }
   popStyle();
  }
  if(punto3){
    float area = edgeFunction(frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y() );
    //println("area: " + area);
  int sizeGrid = (int) pow(2,n-1);
  for(int  i = -sizeGrid ; i < sizeGrid; i++ ){
    for(int j = -sizeGrid; j < sizeGrid; j++){
      //println("i: " + i + ", j: " + j);
      float K_v1v2 = edgeFunction(frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), i, j ),
            K_v2v3 = edgeFunction(frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), i, j ),
            K_v3v1 = edgeFunction(frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), i, j );
        if ((K_v1v2 >=0  && K_v2v3 >= 0 && K_v3v1 >= 0) || (K_v1v2 <=0  && K_v2v3 <=0 && K_v3v1 <=0) ){
              pushStyle();
              colorMode(RGB, 1);
              stroke( K_v1v2/area, K_v2v3/area, K_v3v1/area);
              point(i,j);
              popStyle();
            }   
    }
    
  }
  }
    //rect(-2,-2, 1, 1);
   
}

boolean verifiIntoTriangle( int x, int y){
 float  K_v1v2 = edgeFunction(frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), x, y ),
        K_v2v3 = edgeFunction(frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), x, y ),
        K_v3v1 = edgeFunction(frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), x, y );
     
  return  ((K_v1v2 >=0  && K_v2v3 >= 0 && K_v3v1 >= 0) || (K_v1v2 <=0  && K_v2v3 <=0 && K_v3v1 <=0) );
}
boolean verifiIntoTriangle2( int x, int y){
 float  K_v1v2 = edgeFunction(frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), x, y ),
        K_v2v3 = edgeFunction(frame.coordinatesOf(v2).x(), frame.coordinatesOf(v2).y(), frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), x, y ),
        K_v3v1 = edgeFunction(frame.coordinatesOf(v3).x(), frame.coordinatesOf(v3).y(), frame.coordinatesOf(v1).x(), frame.coordinatesOf(v1).y(), x, y );

  return (((K_v1v2 >=0  && K_v2v3 >= 0 && K_v3v1 >= 0) || (K_v1v2 <=0  && K_v2v3 <=0 && K_v3v1 <=0)  ) && ( -abs(K_v1v2) < 1.0 || -abs(K_v2v3) < 1.0 || -abs(K_v3v1) < 1.0  )  );

}
float edgeFunction( float a_x,  float a_y , float b_x, float b_y, float c_x,  float c_y) 
{ 
    return (((c_x - a_x) * (b_y - a_y)) - ((c_y - a_y) * (b_x - a_x))); 
} 

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void spin() {
  if (scene.is2D())
    scene.eye().rotate(new Quaternion(new Vector(0, 0, 1), PI / 100), scene.anchor());
  else
    scene.eye().rotate(new Quaternion(yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100), scene.anchor());
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 8 ? n+1 : 2;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 8;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
   if(key == '1')
   punto1 = !punto1;
   if(key == '2'){
   punto2 = !punto2;
   if (punto2 != false)
     punto1 = false;
   else
   punto1 = true;
   }
   if(key == '3')
   punto3 = !punto3;

   
}