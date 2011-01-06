object pGetResRefObject(object oTarget, string sResRef="")
{
object oItem=GetFirstItemInInventory(oTarget);
while(GetIsObjectValid(oItem))
    {
    if(GetResRef(oItem)==sResRef) return oItem;

    oItem=GetNextItemInInventory(oTarget);
    };

return OBJECT_INVALID;
}








void main()
{
object oDamager = GetLastDamager();
object oMe=OBJECT_SELF;

int iDealtDam=GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);

if(iDealtDam<=0) return;


int iArrowNum=GetLocalInt(oMe, "pt_ARROWS_IN_BODY");
string sArrowRR=GetLocalString(oMe, "pt_ARROWS_IN_BODY_RR");


object oWeapon=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDamager);
int iWeapType=GetBaseItemType(oWeapon);
object oTrooololo=oWeapon;


object oBullet=GetItemInSlot(INVENTORY_SLOT_BULLETS, oDamager);
object oBolt=GetItemInSlot(INVENTORY_SLOT_BOLTS, oDamager);
object oArrow=GetItemInSlot(INVENTORY_SLOT_ARROWS, oDamager);



if(iWeapType==BASE_ITEM_DART || iWeapType==BASE_ITEM_THROWINGAXE || iWeapType==BASE_ITEM_SHURIKEN)
    {
    }
    else if(iWeapType==BASE_ITEM_SLING)
    {
    oTrooololo=oBullet;
    }
    else if(iWeapType==BASE_ITEM_LIGHTCROSSBOW || iWeapType==BASE_ITEM_HEAVYCROSSBOW)
    {
    oTrooololo=oBolt;
    }
    else if(iWeapType==BASE_ITEM_SHORTBOW || iWeapType==BASE_ITEM_LONGBOW)
    {
    oTrooololo=oArrow;
    }
    else
    {
    return;
    };




//Trowning item ResRef
string sResRef=GetResRef(oTrooololo);
SetLocalString(oMe, "pt_ARROWS_IN_BODY_RR", sResRef);

//Trowning item
object oTrown=pGetResRefObject(oMe, sResRef);
int iTroStack=GetItemStackSize(oTrown);

//Increase
iArrowNum++;
SetLocalInt(oMe, "pt_ARROWS_IN_BODY", iArrowNum);


//Add arrow
if(GetIsObjectValid(oTrown))
    {
    SetItemStackSize(oTrown, iTroStack+1);
    }
    else
    {
    oTrown=CopyItem(oTrooololo, oMe);
    SetItemStackSize(oTrown, 1);
    };
SetDroppableFlag(oTrown, TRUE);



//debug
SendMessageToPC(GetFirstPC(), "Arrows In Body="+IntToString(GetLocalInt(oMe, "pt_ARROWS_IN_BODY")));
}
