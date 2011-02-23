//::////////////////////////////////////////////////////////////////////////////
//:: prop_setuploop
//:: Clear variables, set up the step for cycling properties - single loop strip
//:: Written by Winterknight for Altharia - 11/11/07
//::////////////////////////////////////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nCount = 1;
  SetLocalInt(oAnvil,"currentprop", nCount);
  int nProps = IPGetNumberOfItemProperties(oItem);
  SetLocalInt(oAnvil,"totalprops", nProps);

// Do the display bit
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
