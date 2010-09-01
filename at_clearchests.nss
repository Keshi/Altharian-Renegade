void SweepAndDestroy(object oChest)
{
    object oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }

    DestroyObject(oChest,0.2);

}



void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oChest = GetObjectByTag("enterchest_1");
  if (oChest != OBJECT_INVALID) SweepAndDestroy(oChest);
  oChest = GetObjectByTag("enterchest_2");
  if (oChest != OBJECT_INVALID) SweepAndDestroy(oChest);
  oChest = GetObjectByTag("enterchest_3");
  if (oChest != OBJECT_INVALID) SweepAndDestroy(oChest);
  object oPC = GetObjectByTag("wk_startarms");

  SetLocalInt(oPC,"startchests",0);
  AssignCommand(oClicker,JumpToObject(oTarget));
}
