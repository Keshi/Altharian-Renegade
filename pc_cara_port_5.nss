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
  SetLocalInt(oPC,"cara_port",5);
}
