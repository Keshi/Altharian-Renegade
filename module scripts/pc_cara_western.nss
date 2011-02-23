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
  int nPort = GetLocalInt(oPC,"cara_port");
  location lJump = GetLocation(GetWaypointByTag("WP_pc_cara_west_"+IntToString(nPort)));

  DelayCommand(1.0, AssignCommand(oPC, JumpToLocation(lJump)));
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), GetLocation(oPC));
/*
  Here's the key to this script: you have to ensure that in each location associated
  with a particular token upgrade, you have to create a destination WP labeled
  "WP_pc_cara_west_" plus the number 1-9, based on the destination in sequence from
  the conversation.  The Delath (primary) location will be 8, the Thorelian hub
  will be 9.

  To convert this to the eastern caravan system, simply rename this script as
  pc_cara_eastern, and save the conversation as a new name accordingly.  Then,
  change the descriptions in the conversation nodes to the new destinations in
  the east.  For the eastern loop, change the waypoints, and the above string
  to "WP_pc_cara_east_".
*/
}
