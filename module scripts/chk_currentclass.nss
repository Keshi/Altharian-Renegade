/////:://////////////////////////////////
/////:: Check Current Classes
/////:: Written by Winterknight for Altharia
/////:://////////////////////////////////

void main()
{
  object oPC=GetPCLevellingUp();
  int nLevel = GetHitDice(oPC);
  if (nLevel == 40)
    {
      int nNumClasses = GetCampaignInt("leveler","classcount",oPC);
      int nBadDog = 0;
      if (nNumClasses > 1)
        {
          int nClass2 = GetCampaignInt("leveler","class2",oPC);
          int nCurrClass2 = GetClassByPosition(2,oPC);
          if (nNumClasses > 2)
            {
              int nClass3 = GetCampaignInt("leveler","class3",oPC);
              int nCurrClass3 = GetClassByPosition(3,oPC);
              if (nClass3 != nCurrClass3 & nClass3 != nCurrClass2) nBadDog = 1;
              if (nClass2 != nCurrClass3 & nClass2 != nCurrClass2) nBadDog = 1;
              if (nBadDog ==1)
                {
                  SendMessageToPC(oPC,"You have violated your original build classes.");
                  SendMessageToPC(oPC,"Try again.");
                  int nXP = GetXP(oPC);
                  SetXP(oPC,0);
                  SetXP(oPC,nXP);
                }
            }
        }
    }

}
