void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC,"guild_spellslot",0);
  SetLocalInt(oPC,"guild_ability",0);
  SetLocalInt(oPC,"guild_cost",0);
  int nPoints = GetLocalInt(oPC,"guildarmpts");
  string sPts = IntToString(nPoints);
  SendMessageToPC(oPC,"Points Remaining: "+sPts);
  SetLocalString(oPC,"MODIFY_STRING","");
}
