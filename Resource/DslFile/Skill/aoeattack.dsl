skill(4)
{
	section(10)
	{
    hiteffect(hitEffect, "eyes", 0, 1000, "Stand", 100);
	};
  section(1000)
  {
    animation("Attack");
    adjustsectionduration("anim",100);
    selfeffect(selfEffect,1000,"eyes",0,false)
    {
      transform(vector3(0,1,0));
    };
    aoeimpact(100,0,0,0,false);
  };
};