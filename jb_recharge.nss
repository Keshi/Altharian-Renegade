//Below is a recharge script.  Put it in the ondisturbed event of any container with inventory.  Don't forget to make the inventory a plot item.

//Put a rechargable item and 3 fire opals in the container and the item is put at max charge.

//When choosing the item and number of items needed to recharge bear in mind it's the time taken to get the recharge item that is the true cost, not necessarily the GP value of the recharge item.

//The script will attempt to recharge any non battery item, regardless of whether it's rechargable or not.  C'est la vie.

//This might go well placed in that little Emalf (sp?) room or maybe outside with his students.  He's a magic type guy right?

//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Recharges an item placed in OBJECT_SELF when
  RECHARGE_NUMBER of RECHARGE_BATTERY are placed
  as well.  Destroys all items except first non
  RECHARGE_BATTERY.
*/

 string RECHARGE_BATTERY="NW_IT_GEM009";
 int RECHARGE_NUMBER=3 ;

// Counts the number of tag objects an object has
// looks in bags too.
int CountInventory(object oSource,string Tag)
{
int i;
int count=0;
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent)) {
            if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                count+=CountInventory(oInvent,Tag);
            if (GetTag(oInvent)==Tag) count+=GetItemStackSize(oInvent);
            oInvent=GetNextItemInInventory(oSource);
        }
return count;
}

// Destroys objects except object
void DestroyInventorySpecific(object oSource,object Tag)
{
int i;
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent)) {
             if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                    DestroyInventorySpecific(oInvent,Tag);
                   if (oInvent!=Tag) DestroyObject(oInvent,1.0f);
                    oInvent=GetNextItemInInventory(oSource);
        }

}

void recharge_count(object oSource,string Tag,object oPC)
{
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent)) {
             if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                    recharge_count(oInvent,Tag,oPC);
                   if (GetTag(oInvent)!=Tag) {
                    DestroyInventorySpecific(oSource,oInvent);
// Sets charges left on an item.
// - oItem: item to change
// - nCharges: number of charges.  If value below 0 is passed, # charges will
//   be set to 0.  If value greater than maximum is passed, # charges will
//   be set to maximum.  If the # charges drops to 0 the item
//   will be destroyed.
                    SetItemCharges(oInvent,100);
                    SendMessageToPC (oPC, "Your "+GetName(oInvent)+" has been recharged.");

                        return ;
                    }
                    oInvent=GetNextItemInInventory(oSource);
        }

}
void main()
{
object oItem=GetInventoryDisturbItem();
object oPC=GetLastDisturbed();
if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_ADDED) {
 if (CountInventory(OBJECT_SELF,RECHARGE_BATTERY)>=RECHARGE_NUMBER) {
    // Recharge the first thing that isn't a battery
    // Destroy everthing else.
    recharge_count(OBJECT_SELF,RECHARGE_BATTERY,oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MIRV), OBJECT_SELF);
 } else {
      SendMessageToPC (oPC, "Nothing happens.");
}

}
}
