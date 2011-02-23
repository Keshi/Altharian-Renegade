  void main()
{


object oPC=GetPCSpeaker();




 int dustcount=0;
// kill 3 Nuggets
 object oItem=GetFirstItemInInventory(oPC);
  while  (GetIsObjectValid(oItem))
 {
  if (GetTag(oItem)=="mithrilnugget")
    {
    dustcount++;
    if (dustcount <4) DestroyObject(oItem);
    }

 oItem= GetNextItemInInventory(oPC);
 }


    // and give them the Mithril Weapon Kit 3
        CreateItemOnObject("mc_mithweapkit3", GetPCSpeaker(), 1);

      TakeGoldFromCreature(1000000, oPC, TRUE);
    //Take Mithril Weapon Kit 2
oItem = GetItemPossessedBy(oPC, "mc_mithweapkit2");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);


}




