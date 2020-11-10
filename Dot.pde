class Dot
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  Boolean dead = false;
  Boolean reachedGoal = false;
  Boolean isBest = false;
  
  float fitness = 0;
  
  Brain brain;
 
  Dot()
  {
  brain = new Brain(400, true);
   
  pos = new PVector(width/2,height - 100);
  vel = new PVector(0,0);
  acc = new PVector(0,0); 
  }
  
//---------------------------------------------------------------------
  void Show()
  {
    if (isBest)
    {
      fill(0,255,0);
      ellipse(pos.x,pos.y,8,8);
    }
    else
    {
      fill(0);
      ellipse(pos.x,pos.y,4,4);
    }
  }
 
//---------------------------------------------------------------------
  void Move()
  {
    if (brain.directions.length > brain.steps)
    {
      acc = brain.directions[brain.steps];
      brain.steps++;
    }
    else
    {dead = true;}
    vel.add(acc);
    vel.limit(56);
    pos.add(vel);
  }
//---------------------------------------------------------------------
  void Update()
  {
    if (!dead && !reachedGoal)
    {
      Move();
      if (pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2)
        dead = true;
      else if (pos.x > 2 && pos.y > 200 && pos.x < 400  && pos.y < 230)
        dead = true;
      else if (pos.x > 300 && pos.y > 400 && pos.x < 800  && pos.y < 430)
        dead = true;
      else if (pos.x > 2 && pos.y > 600 && pos.x < 400  && pos.y < 630)
        dead = true;
      else if (dist(pos.x,pos.y,goal.x,goal.y) < 5)
        reachedGoal = true;
    }
  }
//---------------------------------------------------------------------
  void CalculateFitness()
  {
    float distanceToGoal = dist(pos.x,pos.y,goal.x,goal.y);
    if (reachedGoal)
      fitness = 1.0/16.0 + 10000.0/(float)(brain.steps * brain.steps);
    else
      fitness = 1.0/(distanceToGoal * distanceToGoal);
  }

//---------------------------------------------------------------------
  Dot GetBaby()
  {
    Dot baby = new Dot();
    baby.brain = brain.Clone();
    return baby;
  }
}
