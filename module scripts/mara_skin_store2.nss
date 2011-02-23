
void main()
{
   int ObjectCount;
   ObjectCount == 0;
   object oPC = GetPCSpeaker();
   object oItem = GetFirstItemInInventory(oPC);

   while (GetIsObjectValid(oItem))
    {
       if (GetTag(oItem) == "sahuaginhead")
       {
          DestroyObject(oItem);
          GiveGoldToCreature(oPC, 100);
          GiveXPToCreature(oPC, 50);
       }
       oItem = GetNextItemInInventory(oPC);
    }

}

