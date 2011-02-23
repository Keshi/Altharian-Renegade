

#include "nw_i0_plot"


void DestroyInventory(object oSource)
{
int i;
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent)) {
             if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                    DestroyInventory(oInvent);
                   DestroyObject(oInvent,1.0f);
                    oInvent=GetNextItemInInventory(oSource);
        }

}

void createhack(string sRef,object oChest , int iStackSize)
{
    CreateItemOnObject(sRef,oChest,iStackSize);
}

void main()
{
    object oChest=GetObjectByTag("refiningchamber");
    object oPC=GetLastUsedBy();
    int nChips = GetNumItems(oChest,"darkmithrilchip");
    int nCores = nChips/3;

    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

    if (nCores >=1)
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("darkmithrilcore",oChest,nCores));
          SendMessageToPC (oPC, "A great heat emmanates from the Refiner...something has changed.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

    else if (nCores == 0)
        {
          SendMessageToPC (oPC, "There is not enough raw material to work with.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
        }

    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
