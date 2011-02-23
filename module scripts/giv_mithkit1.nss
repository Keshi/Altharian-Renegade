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


    // and give him the Weapon Kit
        CreateItemOnObject("mc_mithweapkit1", GetPCSpeaker(), 1);

      TakeGoldFromCreature(1000000, oPC, TRUE);
}






