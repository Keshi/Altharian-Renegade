//::////////////////////////////////////////////////////////////////////////////
//:: prop_checknext
//:: Check to ensure property is not the last property.
//:: Written by Winterknight for Altharia - 11/11/07
//::////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nCount = GetLocalInt(oAnvil,"currentprop");
  int nProps = GetLocalInt(oAnvil,"totalprops");
  if (nProps > nCount) return TRUE;
    return FALSE;
}
