/////:://///////////////////////////////////////////////////////////////////////
/////:: Upgrade functions for Altharia - written by Winterknight
/////:: Sets local damage integers, timer, local guardian ability values
/////:://///////////////////////////////////////////////////////////////////////

#include "wk_holyavenger"
#include "wk_tools"

void main()
{
  object oPC = GetPCSpeaker();
  string sTag = GetLocalString(oPC,"actitem");
  SetLocalInt(oPC,sTag,2);
  SetLocalInt(oPC,"UpgradeTimer",200);
  string sCheck = GetLocalString(oPC,"actcheck");
  if (sCheck != "" & sCheck != sTag)
  {
    SetLocalInt(oPC,sCheck,0);
  }
  if (sTag == "holysword")
  {
    float fDur = RoundsToSeconds(200);
    DoVesperHolyAvenger(oPC,fDur);
  }

  if (sTag == "archerbow")
  {
    float fDur = RoundsToSeconds(200);
    DoArcherBowUpgrade(oPC,fDur);
  }

  if (sTag == "fulminate" || sTag == "innerpath" || sTag == "holysword")
  {
    int nLevel = GetStrikeLevel(oPC,sTag);
    int nELevel = GetEffectiveLevel(oPC);
    if (nELevel > 40) nLevel = nLevel * nELevel / 40;
    int nDamBase = 125 + nLevel;
    if (sTag == "fulminate") nDamBase = nDamBase + 50;
    SetLocalInt(oPC,"guardiandamage",nDamBase);
  }

  if (sTag == "stilletto" || sTag == "whitegold" || sTag == "archerbow")
  {
    int nLevel = GetStrikeLevel(oPC,sTag);
    int nELevel = GetEffectiveLevel(oPC);
    if (nELevel > 40) nLevel = nLevel * nELevel / 40;
    int nDamBase = 60 + nLevel;
    SetLocalInt(oPC,"guardiandamage",nDamBase);
  }



}
