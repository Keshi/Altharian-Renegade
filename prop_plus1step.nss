// Script for increment/decrement of property cycle, and tokenization.

void main()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nCount = GetLocalInt(oAnvil,"currentprop");
  int nProps = GetLocalInt(oAnvil,"totalprops");
  if (nCount < nProps) nCount++; // increment count by 1 (next property)
  //if (nCount > 1) nCount = nCount - 1; // decrement count by 1 (previous prop)
  SetLocalInt(oAnvil,"currentprop",nCount);
  itemproperty ipLoop = GetFirstItemProperty(oItem);
  int nLoop = 0;
  int nType = -1;
  int nSubType = -1;
  string sType = "Error";
  string sSub;
  string sSubType;
  while (GetIsItemPropertyValid(ipLoop))
  {
    nLoop++;
    if (nLoop == nCount)
    {  // Column "Label" is the property name.
      nType = GetItemPropertyType(ipLoop);
      sType = Get2DAString("itempropdef","Label",nType);
      sSub  = Get2DAString("itempropdef","SubTypeResRef",nType);
      // Column "SubTypeResRef" is the subtype table;
      if (sSub != "****")
      {
        nSubType = GetItemPropertySubType(ipLoop);
        sSubType = Get2DAString(sSub,"Label",nSubType);
      }
    }
  ipLoop = GetNextItemProperty(oItem);
  }

  SetCustomToken(101,sType);
  SetCustomToken(102,sSubType);
}
