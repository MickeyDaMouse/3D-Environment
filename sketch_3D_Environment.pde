import java.awt.Robot;

Robot rbt;

boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ;
float leftRightHeadAngle, upDownHeadAngle;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = height/2;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  upX = 0;
  upY = 1;
  upZ = 0;
  
  leftRightHeadAngle = radians(270);
  //noCursor();
  try
  {
    rbt = new Robot();
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
}

void draw()
{
  background(0);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ);
  drawFloor();
  drawFocalPoint();
  controlCamera();
  
}

void drawFocalPoint()
{
  pushMatrix();
  
  translate(focusX, focusY, focusZ);
  sphere(5);
  
  popMatrix();
}

void drawFloor()
{
  stroke(255);
  for (int x=-2000; x<= 2000; x+= 100)
  {
    line(x, height, -2000, x, height, 2000);
    line(-2000, height, x, 2000, height, x);
  }  
  
}

void controlCamera()
{
  if(wkey)
  {
    eyeX += cos(leftRightHeadAngle) * 10;
    eyeZ += sin(leftRightHeadAngle) * 10;
  }
  if(skey)  
  {
    eyeX -= cos(leftRightHeadAngle) * 10;
    eyeZ -= sin(leftRightHeadAngle) * 10;
  }
  if(akey)
  {
    eyeX -= cos(leftRightHeadAngle + PI/2) * 10;
    eyeZ -= sin(leftRightHeadAngle + PI/2) * 10;
    
  }
  if(dkey)
  {
    eyeX -= cos(leftRightHeadAngle - PI/2) * 10;
    eyeZ -= sin(leftRightHeadAngle - PI/2) * 10;
  }
  
  leftRightHeadAngle += (mouseX - pmouseX)*0.01;
  upDownHeadAngle += (mouseY - pmouseY) * 0.01;
  if(upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if(upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;
  
  focusX = eyeX + cos(leftRightHeadAngle) * 300;
  focusY = eyeY + tan(upDownHeadAngle) * 300;
  focusZ = eyeZ + sin(leftRightHeadAngle) * 300;
  
  if(mouseX > width-2) rbt.mouseMove(3, mouseY);
  else if (mouseX < 2) rbt.mouseMove(width-3, mouseY);
}

void keyPressed()
{
  if(key == 'W' || key == 'w')  wkey = true;
  if(key == 'A' || key == 'a')  akey = true;
  if(key == 'S' || key == 's')  skey = true;
  if(key == 'D' || key == 'd')  dkey = true;
}

void keyReleased()
{
  if(key == 'W' || key == 'w')  wkey = false;
  if(key == 'A' || key == 'a')  akey = false;
  if(key == 'S' || key == 's')  skey = false;
  if(key == 'D' || key == 'd')  dkey = false;
}
