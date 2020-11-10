class Population
{
  float fitnessSum;
  int gen = 1;
  
  int bestDot = 0;
  int minSteps = 400;
  int firstGoal = -1;
  int aliveSum = 0;
  int aliveDots;
  
  Dot[] dots;
  
  Population(int size)
  {
    aliveDots = size;
    dots = new Dot[size];
    
    for (int i = 0; i < size; i++)
      dots[i] = new Dot();
  }
  
//---------------------------------------------------------------------
  void Show()
  {
    for (int i = 1; i < dots.length; i++)
      dots[i].Show();
    dots[0].Show();
  }
 
//---------------------------------------------------------------------
  void Update()
  {
    for (int i = 0; i < dots.length; i++)
      {
      if (dots[i].brain.steps > minSteps)
        dots[i].dead = true;
      else
        dots[i].Update();
      if (dots[i].dead == false)
        aliveSum ++;
      }
      aliveDots = aliveSum;
      aliveSum = 0;
  }
  
//---------------------------------------------------------------------
  void CalculateFitness()
  {
    for (int i = 0; i < dots.length; i++)
      dots[i].CalculateFitness();
  }
  
//---------------------------------------------------------------------
  boolean AllDotsDead()
  {
    for (int i = 0; i < dots.length; i++)
    {
      if (!dots[i].dead && !dots[i].reachedGoal)
        return false;
    }
    return true;
  }

//---------------------------------------------------------------------
  void NaturalSelection()
  {
    Dot[] newDots = new Dot[dots.length];
    SetBestDot();
    aliveDots = dots.length;
    
    newDots[0] = dots[bestDot].GetBaby();
    newDots[0].isBest = true;
    CalculateFitnessSum();
    
    for (int i = 1; i < newDots.length; i++)
    {
      Dot parent = SelectParent();
      newDots[i] = parent.GetBaby();
    }
    dots = newDots.clone();
    gen++;
  }
  
//---------------------------------------------------------------------
  void CalculateFitnessSum()
  {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++)
      fitnessSum += dots[i].fitness;
  }
  
//---------------------------------------------------------------------
  Dot SelectParent()
  {
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    for (int i = 0; i < dots.length; i++)
    {
      runningSum += dots[i].fitness;
      if (runningSum > rand)
        return dots[i];
    }
    return null;
  }
  
//---------------------------------------------------------------------
  void MutateBabies()
  {
    for (int i = 1; i < dots.length; i++)
      dots[i].brain.Mutate();
  }
  
//---------------------------------------------------------------------
  void SetBestDot()
  {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++)
      if (dots[i].fitness > max)
      {
        max = dots[i].fitness;
        maxIndex = i;
      }
    bestDot = maxIndex;
    
    if(dots[bestDot].reachedGoal)
    {
      if (firstGoal == -1)
        firstGoal = gen;
      minSteps = dots[bestDot].brain.steps;
    }
  }
}
