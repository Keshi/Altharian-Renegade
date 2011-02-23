// Script modified from standard search, reward, and destroy
// Modified by Gameskippy on 2/19/05
// *****
// 100 gold for every orc Berserker Tooth
void main()
{
   object oPC = GetPCSpeaker();
   object oItem = GetFirstItemInInventory(oPC);
   int nCount;
   while (GetIsObjectValid(oItem))
   {
      if (GetTag(oItem) == "BerserkersTooth")
      {
         nCount++;
         DestroyObject(oItem);
      }
      oItem = GetNextItemInInventory(oPC);
   }
   GiveGoldToCreature(oPC,(nCount*250));
   GiveXPToCreature(oPC,(nCount*100));

}

