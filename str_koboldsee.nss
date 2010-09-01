//::////////////////////////////////////////////
//:: enter trigger message - Kobold caves
//:: Written by Winterknight for Altharia
//:: Last update 04/19/08
//::////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  if (!GetIsPC(oPC)) return;
  FloatingTextStringOnCreature("You see furtive movement in the corner.",oPC,FALSE);
}
