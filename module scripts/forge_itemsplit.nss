/////::///////////////////////////////////////////////
/////:: forge_itemsplit - Separate into component properties
/////:: Modified by Winterknight on 2/18/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

void main()
{
  effect eTel1 = EffectVisualEffect(VFX_IMP_FROST_L,FALSE);
  effect eTel2 = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION,FALSE);

  object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);

  object oCombine = GetNearestObjectByTag("forge_combine",OBJECT_SELF,1);
  location lTrig1 = GetLocation(oForge);
  location lTrig2 = GetLocation(oCombine);

  object oItem = GetFirstItemInInventory(oForge);   //get only the first item on anvil
  if (!GetIsObjectValid(oItem)) return;             //must have something there
      if (GetIdentified(oItem)==FALSE) SetIdentified (oItem, TRUE);
  string sCraft;
  int nType = GetLocalInt(OBJECT_SELF, "ItemType"); //check for type for crafting
    if (nType == 1) sCraft = "craftingbelt";    // belts and boots
    if (nType == 2) sCraft = "craftingshield";  // armor, helm, shield
    if (nType == 3) sCraft = "craftingdagger";  // melee weapons
    if (nType == 4) sCraft = "craftingcloak";   // cloaks
    if (nType == 5) sCraft = "craftingring";    // rings and ammys
    if (nType == 6) sCraft = "craftingsling";   // bows, x-bows, slings
    if (nType == 7) sCraft = "craftingdirk";    // thrown and ammo
    if (nType == 8) sCraft = "craftingtoken";   // miscellaneous, common

  itemproperty ipFItem;
  int nIPDuration, nCheck, nParam1, nIPType;
  ipFItem = GetFirstItemProperty(oItem);
  object oArea = GetArea(oForge);

//Loop for as long as the ipLoop variable is valid
  while (GetIsItemPropertyValid(ipFItem))
    {
      nCheck = 0;
      nIPDuration = GetItemPropertyDurationType(ipFItem);
      // Check to see if we can prevent the unique mithril powers from being removed.
      //
      nParam1 = GetItemPropertySubType(ipFItem);
      nIPType = GetItemPropertyType(ipFItem);
      if (nIPType == ITEM_PROPERTY_ONHITCASTSPELL)
      {
        if (nParam1 == 125) nCheck = 1;
      }
      if (nIPType == ITEM_PROPERTY_CAST_SPELL)
      {
        if (nParam1 == 329 ||
            nParam1 == 335 ||
            nParam1 == 359 ||
            nParam1 == 537 ||
            nParam1 == 513) nCheck = 1;
      }

      if (Random(100)!= 1 & nIPDuration == DURATION_TYPE_PERMANENT & nCheck != 1)
        {
          object oCraft = CreateItemOnObject(sCraft,oCombine);
          if (GetIsObjectValid(oCraft))
            {
              RemoveItemProperty(oItem, ipFItem);   //take the magic away from object
              AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oCraft);//put property on gem
            }
        }
      else
        {
          if (nCheck == 1) SendMessageToPC(GetPCSpeaker(),"Unique powers not removed.");
          else
          {
            SendMessageToPC(GetPCSpeaker(),"An item property was lost during the separation.");
            RemoveItemProperty(oItem, ipFItem);
          }
        }

      ipFItem=GetNextItemProperty(oItem);       //Next itemproperty on the list...
    }                                           //end of while
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel1,lTrig1,0.0);
  DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel2,lTrig2,0.0));
  RecomputeStaticLighting(oArea);
}
