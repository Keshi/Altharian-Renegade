void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC,"WEAP_DAMAGE",0);
  SetLocalInt(oPC,"WEAP_COST",0);
  SetLocalString(oPC,"WEAP_STRING","");
  SetLocalInt(oPC,"MAST_MOD",0);
  SetLocalInt(oPC,"WEAP_COLLCOST",0);
}
