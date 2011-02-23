//::////////////////////////////////////////////////////////////////////////////
//:: Upgrade system for the guardians, written by Winterknight for Altharia
//:: The upgrade script sets the campaign string and the campaign int that
//:: are then used by the other portions of the system to work the magic.
//::////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  string sTag = GetTag(OBJECT_SELF);
  SetCampaignString("Character","guardianpath",sTag,oPC);
  SetCampaignInt("Character","guardlevel",1,oPC);
}
