void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);


   int aurumcount=0;
   object oFight=GetFirstObjectInArea (OBJECT_SELF) ;
    while (GetIsObjectValid(oFight) )
    {
        if (GetObjectType(oFight)==OBJECT_TYPE_CREATURE &&
        (GetTag(oFight)=="pc_GreenDragon"||GetTag(oFight)=="pc_Torch"||
        GetTag(oFight)=="pc_GreaterIceWyrm"||GetTag(oFight)=="pc_StormDragon"
         ||GetTag(oFight)=="pc_RiftDragon")  )
        {
         aurumcount=aurumcount+ 1;
        }
    oFight=GetNextObjectInArea (OBJECT_SELF);
    }




   if( aurumcount==0||GetArea(oClicker)==GetObjectByTag("Riftt77_5Rift2") )
    {
    AssignCommand(oClicker,JumpToObject(oTarget));
    }
    else
    {
    SendMessageToPC(oClicker,"The door remains barred while a Dragon Spawn lives.");

    }



}

