//::////////////////////////////////////////////////////////////////////////////
//:: prop_validprops
//:: Check to ensure properties are still on the item.
//:: Written by Winterknight for Altharia - 11/11/07
//::////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nProps = GetLocalInt(oAnvil,"totalprops");
  if (nProps > 0) return TRUE;
    return FALSE;
}
