
void main()
{
    int ObjectCount = 0;
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);

    while (oItem != OBJECT_INVALID)
      {
       if (GetTag(oItem) == "umberhide")
         {
          DestroyObject(oItem, 0.2);
          ObjectCount++;
         }
       oItem = GetNextItemInInventory(oPC);
      }
    GiveGoldToCreature(oPC, ObjectCount*100);
    GiveXPToCreature(oPC, ObjectCount*100);
}

