// Script for increment/decrement of property cycle, and tokenization.

void main()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nCount = GetLocalInt(oAnvil,"currentprop");
  int nProps = GetLocalInt(oAnvil,"totalprops");
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
    { // Remove the correct property.
      RemoveItemProperty(oItem,ipLoop);
      SetLocalInt(oAnvil,"totalprops",nProps-1);
      effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oAnvil);
    }
  ipLoop = GetNextItemProperty(oItem);
  }
}
