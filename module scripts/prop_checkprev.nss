//::////////////////////////////////////////////////////////////////////////////
//:: prop_checkprev
//:: Check to ensure able to go back one step (2nd or higher property).
//:: Written by Winterknight for Altharia - 11/11/07
//::////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  int nCount = GetLocalInt(oAnvil,"currentprop");
  if (nCount > 1) return TRUE;
    return FALSE;
}
