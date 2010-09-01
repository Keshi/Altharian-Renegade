/////:://////////////////////////////////
/////:: Record Current Classes
/////:: Written by Winterknight for Altharia
/////:://////////////////////////////////

void main()
{
  int nReleveled = 3;
  object oPC = GetPCSpeaker();
  int nClass2 = GetClassByPosition(2,oPC);
  int nClass3 = GetClassByPosition(3,oPC);
  if (nClass3 == CLASS_TYPE_INVALID) nReleveled = 2;
  if (nClass2 == CLASS_TYPE_INVALID) nReleveled = 1;
  SetCampaignInt("leveler","classcount",nReleveled,oPC);
  if (nClass2 != CLASS_TYPE_INVALID) SetCampaignInt("leveler","class2",nClass2,oPC);
  if (nClass3 != CLASS_TYPE_INVALID) SetCampaignInt("leveler","class3",nClass3,oPC);
}

