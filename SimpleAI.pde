Population test;
PVector goal = new PVector(400,50);

void setup()
{
size(800,800);
test = new Population(1000);
}

void draw()
{
  background(255);
  
  fill(255,0,0);
  text("Generation: " + test.gen,100,100);
  
  fill(255,0,0);
  text("Steps: " + test.minSteps,600,100);
  
  fill(255,0,0);
  text("Alive dots: " + test.aliveDots,100,75);
  
  fill(255,0,0);
  if (test.firstGoal == -1)
    text("Fisrt Generation to goal: None",100,50);
  else
    text("Fisrt Generation to goal: " + test.firstGoal,100,50);
  
  fill(255,0,0);
  ellipse(goal.x,goal.y,4,4);
  
  fill(0,0,200);
  rect(0,200,400,30);
  
  fill(0,0,200);
  rect(0,600,400,30);
  
  fill(0,0,200);
  rect(300,400,800,30);
  
  if (test.AllDotsDead())
  {
    test.CalculateFitness();
    test.NaturalSelection();
    test.MutateBabies();
  }
  else
  {
  test.Update();
  test.Show();
  }
}
