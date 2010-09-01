void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC,"MAST_DAMAGE",0);
  SetLocalString(oPC,"MAST_STRING","");
  SetLocalInt(oPC,"MAST_MOD",0);
  SetLocalInt(oPC,"MAST_COLLCOST",0);
  SetLocalInt(oPC,"MAST_USES",10);
}
