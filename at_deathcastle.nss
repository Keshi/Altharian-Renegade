
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);


   int hungrycount=0;
   object oFight=GetFirstObjectInArea (OBJECT_SELF) ;
    while (GetIsObjectValid(oFight) )
    {
        if (GetObjectType(oFight)==OBJECT_TYPE_CREATURE &&
            GetTag (oFight)=="hungrydemon")
        {
         hungrycount=hungrycount+ 1;
        }
         oFight=GetNextObjectInArea (OBJECT_SELF);
     }




   if( hungrycount==0)
    {
    AssignCommand(oClicker,JumpToObject(oTarget));
    }
    else
    {
    SendMessageToPC(oClicker,"The door remains barred while a Soulhungry demon lives.");

    }



}
