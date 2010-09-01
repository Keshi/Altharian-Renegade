//:://////////////////////////////////////////////////////////////////////
//:: Templates for using cantrips as placeholders
//:: Written by Winterknight for Altharia
//:: Last update 05/12/08
//:://////////////////////////////////////////////////////////////////////


void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC,"caravan_token");
  if (oItem == OBJECT_INVALID) return;
      // First, do a check to ensure player has the token.  Break the script
      // if they don't have one.
  itemproperty ipAdd, ipItem;
  int nTrue;
  ipAdd = ItemPropertyCastSpell (IP_CONST_CASTSPELL_ELECTRIC_JOLT_1, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
  ipItem = GetFirstItemProperty(oItem);
  while (GetIsItemPropertyValid(ipItem))
  {
    if (ipItem == ipAdd) nTrue = 1;
    ipItem = GetNextItemProperty(oItem);
    // This loop is to ensure the item doesn't already have the property.
  }
  if (nTrue != 1)
  {
    AddItemProperty(DURATION_TYPE_PERMANENT, ipAdd, oItem);
  }


}
