//::////////////////////////////////////////////////////////////////////////////
//:: prop_checknext
//:: Check to ensure property is not the last property.
//:: Written by Winterknight for Altharia - 11/11/07
//::////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oAnvil = GetNearestObjectByTag("wk_itemstripper");
  object oItem = GetFirstItemInInventory(oAnvil);
  if (!GetIsObjectValid(oItem)) return TRUE;
    return FALSE;
}
