//::///////////////////////////////////////////////
//:: Recharge bench script
//:: modified by Winterknight for Altharia
//:://////////////////////////////////////////////

 int RECHARGE_BATTERY=BASE_ITEM_GEM;
 int RECHARGE_NUMBER=4500 ;

// Counts the number of tag objects an object has
// looks in bags too.
int CountInventory(object oSource,int Gem)
{
int i = 0;
int nValue;
int count=0;
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent))
        {
            if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                count+=CountInventory(oInvent,Gem);
            if (GetBaseItemType(oInvent)==Gem)
                count+=GetItemStackSize(oInvent);
            nValue = GetGoldPieceValue(oInvent);
            i = i + nValue;
            oInvent=GetNextItemInInventory(oSource);
        }
return i;
}

// Destroys objects except object
void DestroyInventorySpecific(object oSource,object oItem)
{
  int i;
  object oInvent=GetFirstItemInInventory(oSource);
  while (GetIsObjectValid(oInvent))
    {
      if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
        DestroyInventorySpecific(oInvent,oItem);
      if (oInvent!=oItem)
        DestroyObject(oInvent,1.0f);
      oInvent=GetNextItemInInventory(oSource);
    }
}

void recharge_count(object oSource,int Gem,object oPC)
{
  object oInvent = GetFirstItemInInventory(oSource);
  while (GetIsObjectValid(oInvent))
    {
      if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
        recharge_count(oInvent,Gem,oPC);
      if (GetBaseItemType(oInvent)!=Gem)
        {
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
    if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_ADDED)
      {
        if (CountInventory(OBJECT_SELF,RECHARGE_BATTERY)>=RECHARGE_NUMBER)
          {
            // Recharge the first thing that isn't a battery
            // Destroy everthing else.
            recharge_count(OBJECT_SELF,RECHARGE_BATTERY,oPC);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MIRV), OBJECT_SELF);
          }
        else
          {
            SendMessageToPC (oPC, "Nothing happens.");
          }
      }
}
