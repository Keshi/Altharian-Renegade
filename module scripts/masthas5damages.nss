int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC,"MAST_MODIFY");
    int nTally;
    itemproperty ipFItem;
    int nType;
    if (GetIsObjectValid(oItem))
      {
        ipFItem = GetFirstItemProperty(oItem);                 //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipFItem))
          {
            nType = GetItemPropertyType(ipFItem);
            if (nType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE ||
                nType == ITEM_PROPERTY_DAMAGE_REDUCTION ||
                nType == ITEM_PROPERTY_DAMAGE_RESISTANCE) nTally++;
            ipFItem=GetNextItemProperty(oItem);
          }
      }
    if (nTally>4) return FALSE;

    return TRUE;
}
