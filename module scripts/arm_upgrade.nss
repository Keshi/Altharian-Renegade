/////::///////////////////////////////////////////////
/////:: armor_upgrade - Add new property to armor
/////:: Complete overhaul by Winterknight on 12/28/07
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetLocalObject(oPC,"MODIFY_ITEM");
  if (!GetIsObjectValid(oItem)) return;             //must have something there
  itemproperty ipFItem;
  int nCost = GetLocalInt(oPC,"guild_cost");
  string sCraft = GetLocalString(oPC,"MODIFY_STRING");
  int nVal;
  int nSub;
  int nKeep = X2_IP_ADDPROP_POLICY_REPLACE_EXISTING;

/*The new system works by finding what the modification string is, and then
  setting the correct type of item property modification from that value.

  Sub categories have to be managed for different point values by type as well.
  Tricky, but manageable, but errors in the system are possible.
*/

// AC Bonuses
  if (sCraft == "guild_aclyt")
  {
    if (nCost == 1) nVal = 4;
    if (nCost == 2) nVal = 7;
    if (nCost == 4) nVal = 10;
    ipFItem = ItemPropertyACBonus(nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_acmed")
  {
    if (nCost == 1) nVal = 5;
    if (nCost == 2) nVal = 10;
    if (nCost == 4) nVal = 15;
    ipFItem = ItemPropertyACBonus(nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_achvy")
  {
    if (nCost == 1) nVal = 7;
    if (nCost == 2) nVal = 14;
    if (nCost == 4) nVal = 20;
    ipFItem = ItemPropertyACBonus(nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Ability bonuses
  if (sCraft == "guild_cha")
  {
    nSub = IP_CONST_ABILITY_CHA;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_con")
  {
    nSub = IP_CONST_ABILITY_CON;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_dex")
  {
    nSub = IP_CONST_ABILITY_DEX;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_int")
  {
    nSub = IP_CONST_ABILITY_INT;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_str")
  {
    nSub = IP_CONST_ABILITY_STR;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_wis")
  {
    nSub = IP_CONST_ABILITY_WIS;
    if (nCost == 1) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyAbilityBonus(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// spell slots
  if (sCraft == "guild_bard")
  {
    nSub = CLASS_TYPE_BARD;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 4;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+2);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_cler")
  {
    nSub = CLASS_TYPE_CLERIC;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 4;
    if (nCost == 4) nVal = 7;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+2);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_drui")
  {
    nSub = CLASS_TYPE_DRUID;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 4;
    if (nCost == 4) nVal = 7;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+2);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_sorc")
  {
    nSub = CLASS_TYPE_SORCERER;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 4;
    if (nCost == 4) nVal = 7;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+2);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_wzrd")
  {
    nSub = CLASS_TYPE_WIZARD;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 4;
    if (nCost == 4) nVal = 7;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+2);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_pall")
  {
    nSub = CLASS_TYPE_PALADIN;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 3;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_rang")
  {
    nSub = CLASS_TYPE_RANGER;
    nKeep = X2_IP_ADDPROP_POLICY_IGNORE_EXISTING;
    if (nCost == 2) nVal = 1;
    if (nCost == 3) nVal = 3;
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
    ipFItem = ItemPropertyBonusLevelSpell(nSub,nVal+1);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Damage resistance
  if (sCraft == "guild_drbludg")
  {
    nSub = 0;
    if (nCost == 2) nVal = IP_CONST_DAMAGERESIST_10;
    if (nCost == 4) nVal = IP_CONST_DAMAGERESIST_20;
    if (nCost == 6) nVal = IP_CONST_DAMAGERESIST_30;
    if (nCost == 8) nVal = IP_CONST_DAMAGERESIST_40;
    if (nCost == 10) nVal = IP_CONST_DAMAGERESIST_50;
    ipFItem = ItemPropertyDamageResistance(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_drpierc")
  {
    nSub = 1;
    if (nCost == 2) nVal = IP_CONST_DAMAGERESIST_10;
    if (nCost == 4) nVal = IP_CONST_DAMAGERESIST_20;
    if (nCost == 6) nVal = IP_CONST_DAMAGERESIST_30;
    if (nCost == 8) nVal = IP_CONST_DAMAGERESIST_40;
    if (nCost == 10) nVal = IP_CONST_DAMAGERESIST_50;
    ipFItem = ItemPropertyDamageResistance(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_drslash")
  {
    nSub = 2;
    if (nCost == 2) nVal = IP_CONST_DAMAGERESIST_10;
    if (nCost == 4) nVal = IP_CONST_DAMAGERESIST_20;
    if (nCost == 6) nVal = IP_CONST_DAMAGERESIST_30;
    if (nCost == 8) nVal = IP_CONST_DAMAGERESIST_40;
    if (nCost == 10) nVal = IP_CONST_DAMAGERESIST_50;
    ipFItem = ItemPropertyDamageResistance(nSub,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Regen
  if (sCraft == "guild_regen")
  {
    if (nCost == 2) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyRegeneration(nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// USTB
  if (sCraft == "guild_ustb")
  {
    if (nCost == 2) nVal = 3;
    if (nCost == 3) nVal = 6;
    if (nCost == 5) nVal = 10;
    ipFItem = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Skill bonuses
  if (sCraft == "guild_skanemp")
  {
    nSub = SKILL_ANIMAL_EMPATHY;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skconcen")
  {
    nSub = SKILL_CONCENTRATION;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skdisc")
  {
    nSub = SKILL_DISCIPLINE;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skheal")
  {
    nSub = SKILL_HEAL;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skhide")
  {
    nSub = SKILL_HIDE;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_sklisten")
  {
    nSub = SKILL_LISTEN;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skmovesi")
  {
    nSub = SKILL_MOVE_SILENTLY;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skparry")
  {
    nSub = SKILL_PARRY;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_sksearch")
  {
    nSub = SKILL_SEARCH;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skspcrft")
  {
    nSub = SKILL_SPELLCRAFT;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_skspot")
  {
    nSub = SKILL_SPOT;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_sktaunt")
  {
    nSub = SKILL_TAUNT;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_sktumble")
  {
    nSub = SKILL_TUMBLE;
    if (nCost == 1) nVal = 10;
    if (nCost == 3) nVal = 20;
    if (nCost == 6) nVal = 30;
    ipFItem = ItemPropertySkillBonus(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Immunities
  if (sCraft == "guild_immdis")
  {
    nSub = IP_CONST_IMMUNITYMISC_DISEASE;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immfear")
  {
    nSub = IP_CONST_IMMUNITYMISC_FEAR;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immpois")
  {
    nSub = IP_CONST_IMMUNITYMISC_POISON;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immsneak")
  {
    nSub = IP_CONST_IMMUNITYMISC_BACKSTAB;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immdeath")
  {
    nSub = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immmind")
  {
    nSub = IP_CONST_IMMUNITYMISC_MINDSPELLS;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immpara")
  {
    nSub = IP_CONST_IMMUNITYMISC_PARALYSIS;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immknock")
  {
    nSub = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immdrain")
  {
    nSub = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_immcrits")
  {
    nSub = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;
    ipFItem = ItemPropertyImmunityMisc(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Non-categorized
  if (sCraft == "guild_arcsf50")
  {
    nSub = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_50_PERCENT;
    ipFItem = ItemPropertyArcaneSpellFailure(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_truesee")
  {
    ipFItem = ItemPropertyTrueSeeing();
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

  if (sCraft == "guild_wtred80")
  {
    nSub = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
    ipFItem = ItemPropertyWeightReduction(nSub);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

// Guild special ability uses

  if (sCraft == "guild_special")
  {
    nSub = IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY;
    if (nCost == 2) nVal = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
    if (nCost == 4) nVal = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
    if (nCost == 6) nVal = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
    ipFItem = ItemPropertyCastSpell(nSub, nVal);
    IPSafeAddItemProperty(oItem,ipFItem,0.0,nKeep,FALSE,FALSE);
  }

}
