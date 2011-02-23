/////::///////////////////////////////////////////////
/////:: champ_upgrade - Separate into component properties
/////:: Modified by Winterknight on 6/09/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oForge = GetNearestObjectByTag("hiddenforge",OBJECT_SELF,1);
  object oCombine = GetNearestObjectByTag("hiddencombine",OBJECT_SELF,1);
  object oPC = GetPCSpeaker();
  object oCraft;
  object oTool;
  object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
  if (!GetIsObjectValid(oItem)) return;             //must have something there
  string sCraft = "craftingbelt";  // boots
//  int nCash;
  itemproperty ipFItem = GetFirstItemProperty(oItem);

// First thing: strip the existing properties from the item, store them in the combine.
// Loop for as long as the variable is valid

  while (GetIsItemPropertyValid(ipFItem))
    {
       oCraft = CreateItemOnObject(sCraft,oCombine);
       if (GetIsObjectValid(oCraft))
            {
              RemoveItemProperty(oItem, ipFItem);   //take the magic away from object
              AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oCraft);//put property on gem
            }

      ipFItem=GetNextItemProperty(oItem);       //Next itemproperty on the list...
    }                                           //end of Item strip

// Next, we will get the local variables, create the upgrade item on the forge.
// *****************************************************************************
      sCraft = GetLocalString(oPC,"upgradeitem");
      CreateItemOnObject(sCraft,oForge,1);
//      nCash = GetLocalInt(oPC,"cashout");
                                     //end of variables and item creation.
// *****************************************************************************
// Finally, we will merge the props from forge into the item in hand.

// Do the forge.
  oTool = GetFirstItemInInventory(oForge);

  while (GetIsObjectValid(oTool))
    {
      ipFItem = GetFirstItemProperty(oTool);
      while (GetIsItemPropertyValid(ipFItem))
        {
          AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);
          RemoveItemProperty(oTool, ipFItem);
          ipFItem=GetNextItemProperty(oTool);
        }
      DestroyObject(oTool);
      oTool = GetNextItemInInventory(oForge);
    }
// Last thing: take the money
//  TakeGoldFromCreature(nCash,oPC,TRUE);

}
