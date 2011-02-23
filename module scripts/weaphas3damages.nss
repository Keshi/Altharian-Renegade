int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC,"WEAP_MODIFY");
    int nTally;
    itemproperty ipFItem;
    int nType;
    if (GetIsObjectValid(oItem))
      {
        ipFItem = GetFirstItemProperty(oItem);                 //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipFItem))
          {
            nType = GetItemPropertyType(ipFItem);
            if (nType == ITEM_PROPERTY_DAMAGE_BONUS ||
                nType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE) nTally++;
            ipFItem=GetNextItemProperty(oItem);
          }
      }
    if (nTally>2) return FALSE;

    return TRUE;
}
