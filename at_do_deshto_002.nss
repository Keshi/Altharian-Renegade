
void main()
{
  object oPC = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  int nCount;
  int nTest = GetCampaignInt("altharia","DasBracer",oPC);
  if (nTest == 1) nCount++;
  nTest = GetCampaignInt("altharia","DasAmmy",oPC);
  if (nTest == 1) nCount++;

  if (nCount < 3)
  {
    int nTest = GetLocalInt(GetObjectByTag("Dela_dashjewelroom",1),"occupants");
    if (nTest == 0) AssignCommand(oPC,JumpToObject(oTarget));
    else if (nTest > 0)
    {
      FloatingTextStringOnCreature("Only ONE may enter at a time.",oPC,TRUE);
      return;
    }
  }
}
