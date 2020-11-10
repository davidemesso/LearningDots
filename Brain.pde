class Brain
{
 PVector[] directions;
 int steps = 0;
 
 Brain (int size, boolean first)
 {
   directions = new PVector[size];
   if(first)
     Randomize();
 }
  
//---------------------------------------------------------------------
 void Randomize()
 {
   for(int i = 0; i < directions.length; i++)
     directions[i] = PVector.fromAngle(random(2*PI));
 }

//---------------------------------------------------------------------
  Brain Clone()
  {
    Brain clone = new Brain(directions.length, false);
    for(int i = 0; i < directions.length; i++)
      clone.directions[i] = directions[i].copy();
    return clone;
  }

//---------------------------------------------------------------------
  void Mutate()
  {
    float mutationRate = 0.03;
    for(int i = 0; i < directions.length; i++)
    {
      float rand = random(1);
      if (rand < mutationRate)
      {
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
