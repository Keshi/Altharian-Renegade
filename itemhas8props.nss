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
            if (nType==ITEM_PROPERTY_ON_HIT_PROPERTIES ||
                nType==ITEM_PROPERTY_ONHITCASTSPELL ||
                nType==ITEM_PROPERTY_CAST_SPELL)
                {
                  nTally = nTally - 1;
                }
            nTally++;
            ipFItem=GetNextItemProperty(oItem);
          }
      }
    if (nTally<8) return FALSE;

    return TRUE;
}
