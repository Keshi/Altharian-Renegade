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
  SetLocalInt(oPC,sTag,3);
  int nLast = 200;
  SetLocalInt(oPC,"UpgradeTimer",nLast);
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
    effect Boost1 = EffectRegenerate(30,6.0);
    effect Boost2 = EffectACIncrease(10,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect Boost3 = EffectAttackIncrease(5,ATTACK_BONUS_MISC);
    effect eLink = EffectLinkEffects(Boost3,Boost2);
    eLink = EffectLinkEffects(eLink,Boost1);
    SupernaturalEffect(eLink);
    float fDur = IntToFloat(nLast) * 6.0;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,fDur);
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
