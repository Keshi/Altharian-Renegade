//:://////////////////////////////////////////////////////////////////////
//:: Templates for using cantrips as placeholders
//:: Written by Winterknight for Altharia
//:: Last update 05/12/08
//:://////////////////////////////////////////////////////////////////////



//:://////////////////////////////////////////////////////////////////:://
//::                  Starting Conditional Function                   :://
//:://////////////////////////////////////////////////////////////////:://

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC,"caravan_token");
  if (oItem == OBJECT_INVALID) return FALSE;
      // First, do a check to ensure player has the token.  Break the script
      // if they don't have one.
  itemproperty ipCheck, ipItem;
  int nTrue = FALSE;
  ipCheck = ItemPropertyCastSpell (IP_CONST_CASTSPELL_LIGHT_1, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
  ipItem = GetFirstItemProperty(oItem);
  while (GetIsItemPropertyValid(ipItem))
  {
    if (ipItem == ipCheck) nTrue = TRUE;
    ipItem = GetNextItemProperty(oItem);
  }
  return nTrue;
}
