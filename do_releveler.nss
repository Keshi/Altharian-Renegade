/////:://////////////////////////////////
/////:: Releveler main
/////:: Written by Winterknight for Altharia
/////:://////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nCurrXP = GetXP(oPC);
  SetXP(oPC,0);
  SetXP(oPC,nCurrXP);
  TakeGoldFromCreature(1000000,oPC,TRUE);

}
