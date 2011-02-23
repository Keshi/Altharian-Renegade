////////////////////////////////////////////////////////////////////
//: wk_viseffects       (Include file)
//: Script for adding visual effects to weapons.
////////////////////////////////////////////////////////////////////
#include "x2_inc_itemprop"

void EvilImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
IPSafeAddItemProperty(oItem, ipAdd);
}

void HolyImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);
IPSafeAddItemProperty(oItem, ipAdd);
}

void FireImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_FIRE);
IPSafeAddItemProperty(oItem, ipAdd);
}

void ElecImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL);
IPSafeAddItemProperty(oItem, ipAdd);
}

void AcidImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_ACID);
IPSafeAddItemProperty(oItem, ipAdd);
}


//void main(){}
