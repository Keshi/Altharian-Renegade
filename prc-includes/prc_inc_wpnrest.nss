//::///////////////////////////////////////////////
//:: Weapon Restriction System Include
//:: prc_inc_restwpn.nss
//::///////////////////////////////////////////////
/*
    Functions to support PnP Weapon Proficiency and
    weapon feat chain simulation
*/
//:://////////////////////////////////////////////
//:: Created By: Fox
//:: Created On: Feb 2, 2008
//:://////////////////////////////////////////////

#include "prc_inc_fork"
#include "inc_item_props"
#include "prc_x2_itemprop"

/**
 * All of the following functions use the following parameters:
 *
 * @param oPC       The character weilding the weapon
 * @param oItem     The item in question.
 * @param nHand     The hand the weapon is wielded in.  In the form of 
 *                  ATTACK_BONUS_ONHAND or ATTACK_BONUS_OFFHAND.
 */
 
 //return if PC has proficiency in an item
int IsProficient(object oPC, int nBaseItem)
{
    int bProficient = FALSE;

  switch(nBaseItem)
  {
      case BASE_ITEM_SHORTSWORD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_MINDBLADE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SHORTSWORD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_LONGSWORD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_MINDBLADE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_LONGSWORD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_BATTLEAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_BATTLEAXE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_BASTARDSWORD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_MINDBLADE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_BASTARD_SWORD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_LIGHTFLAIL:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_LIGHT_FLAIL, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_WARHAMMER:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_WARHAMMER, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_LONGBOW:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_LONGBOW, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_LIGHTMACE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_LIGHT_MACE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_HALBERD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_HALBERD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SHORTBOW:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SHORTBOW, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_TWOBLADEDSWORD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_TWO_BLADED_SWORD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_GREATSWORD:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_GREATSWORD, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_GREATAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_GREATAXE, oPC))
            bProficient = TRUE;  break;

      case BASE_ITEM_DART:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DART, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_DIREMACE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DIRE_MACE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_DOUBLEAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DOUBLE_AXE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_HEAVYFLAIL:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_HEAVY_FLAIL, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_LIGHTHAMMER:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_LIGHT_HAMMER, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_HANDAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_HANDAXE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_KAMA:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_KAMA, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_KATANA:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_KATANA, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_KUKRI:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_KUKRI, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_MORNINGSTAR:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_MORNINGSTAR, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_RAPIER:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_RAPIER, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SCIMITAR:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SCIMITAR, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SCYTHE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SCYTHE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SHORTSPEAR:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SHORTSPEAR, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SHURIKEN:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SHURIKEN, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SICKLE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SICKLE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_SLING:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SLING, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_THROWINGAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC)
             || GetHasFeat(FEAT_MINDBLADE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_THROWING_AXE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_CSLASHWEAPON:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_CPIERCWEAPON:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_CBLUDGWEAPON:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_CSLSHPRCWEAP:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_TRIDENT:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_TRIDENT, oPC))
            bProficient = TRUE; break;

      //special case: counts as martial for dwarves
      case BASE_ITEM_DWARVENWARAXE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC) && GetHasFeat(FEAT_DWARVEN, oPC))
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_DWARVEN_WARAXE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_WHIP:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_WHIP, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_ELF_LIGHTBLADE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELVEN_LIGHTBLADE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_ELF_THINBLADE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELVEN_THINBLADE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_ELF_COURTBLADE:
          if(GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oPC)
             || GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELVEN_COURTBLADE, oPC))
            bProficient = TRUE; break;

      case BASE_ITEM_DAGGER:
      case BASE_ITEM_LIGHTCROSSBOW:
      case BASE_ITEM_HEAVYCROSSBOW:
      case BASE_ITEM_CLUB:
      case BASE_ITEM_QUARTERSTAFF:
           bProficient = TRUE; break;

      default:
           bProficient = TRUE; break;

  }

  return bProficient;
}

//gets the main weapon proficiency feat needed for a given weapon - mostly for Favored Soul
int GetWeaponProfFeatByType(int nBaseType)
{
    switch(nBaseType)
  {
        case BASE_ITEM_SHORTSWORD:
          return FEAT_WEAPON_PROFICIENCY_SHORTSWORD;

      case BASE_ITEM_LONGSWORD:
          return FEAT_WEAPON_PROFICIENCY_LONGSWORD;

      case BASE_ITEM_BATTLEAXE:
          return FEAT_WEAPON_PROFICIENCY_BATTLEAXE;

      case BASE_ITEM_BASTARDSWORD:
          return FEAT_WEAPON_PROFICIENCY_BASTARD_SWORD;

      case BASE_ITEM_LIGHTFLAIL:
          return FEAT_WEAPON_PROFICIENCY_LIGHT_FLAIL;

      case BASE_ITEM_WARHAMMER:
          return FEAT_WEAPON_PROFICIENCY_WARHAMMER;

      case BASE_ITEM_LONGBOW:
          return FEAT_WEAPON_PROFICIENCY_LONGBOW;

      case BASE_ITEM_LIGHTMACE:
          return FEAT_WEAPON_PROFICIENCY_LIGHT_MACE;

      case BASE_ITEM_HALBERD:
          return FEAT_WEAPON_PROFICIENCY_HALBERD;

      case BASE_ITEM_SHORTBOW:
          return FEAT_WEAPON_PROFICIENCY_SHORTBOW;

      case BASE_ITEM_TWOBLADEDSWORD:
          return FEAT_WEAPON_PROFICIENCY_TWO_BLADED_SWORD;

      case BASE_ITEM_GREATSWORD:
          return FEAT_WEAPON_PROFICIENCY_GREATSWORD;

      case BASE_ITEM_GREATAXE:
          return FEAT_WEAPON_PROFICIENCY_GREATAXE;

      case BASE_ITEM_DART:
          return FEAT_WEAPON_PROFICIENCY_DART;

      case BASE_ITEM_DIREMACE:
          return FEAT_WEAPON_PROFICIENCY_DIRE_MACE;

      case BASE_ITEM_DOUBLEAXE:
          return FEAT_WEAPON_PROFICIENCY_DOUBLE_AXE;

      case BASE_ITEM_HEAVYFLAIL:
          return FEAT_WEAPON_PROFICIENCY_HEAVY_FLAIL;

      case BASE_ITEM_LIGHTHAMMER:
          return FEAT_WEAPON_PROFICIENCY_LIGHT_HAMMER;

      case BASE_ITEM_HANDAXE:
          return FEAT_WEAPON_PROFICIENCY_HANDAXE;

      case BASE_ITEM_KAMA:
          return FEAT_WEAPON_PROFICIENCY_KAMA;

      case BASE_ITEM_KATANA:
          return FEAT_WEAPON_PROFICIENCY_KATANA;

      case BASE_ITEM_KUKRI:
          return FEAT_WEAPON_PROFICIENCY_KUKRI;

      case BASE_ITEM_MORNINGSTAR:
          return FEAT_WEAPON_PROFICIENCY_MORNINGSTAR;

      case BASE_ITEM_RAPIER:
          return FEAT_WEAPON_PROFICIENCY_RAPIER;

      case BASE_ITEM_SCIMITAR:
          return FEAT_WEAPON_PROFICIENCY_SCIMITAR;

      case BASE_ITEM_SCYTHE:
          return FEAT_WEAPON_PROFICIENCY_SCYTHE;

      case BASE_ITEM_SHORTSPEAR:
          return FEAT_WEAPON_PROFICIENCY_SHORTSPEAR;

      case BASE_ITEM_SHURIKEN:
          return FEAT_WEAPON_PROFICIENCY_SHURIKEN;

      case BASE_ITEM_SICKLE:
          return FEAT_WEAPON_PROFICIENCY_SICKLE;

      case BASE_ITEM_SLING:
          return FEAT_WEAPON_PROFICIENCY_SLING;

      case BASE_ITEM_THROWINGAXE:
          return FEAT_WEAPON_PROFICIENCY_THROWING_AXE;

      case BASE_ITEM_CSLASHWEAPON:
          return FEAT_WEAPON_PROFICIENCY_CREATURE;

      case BASE_ITEM_CPIERCWEAPON:
          return FEAT_WEAPON_PROFICIENCY_CREATURE;

      case BASE_ITEM_CBLUDGWEAPON:
          return FEAT_WEAPON_PROFICIENCY_CREATURE;

      case BASE_ITEM_CSLSHPRCWEAP:
          return FEAT_WEAPON_PROFICIENCY_CREATURE;

      case BASE_ITEM_TRIDENT:
          return FEAT_WEAPON_PROFICIENCY_TRIDENT;

      case BASE_ITEM_DWARVENWARAXE:
          return FEAT_WEAPON_PROFICIENCY_DWARVEN_WARAXE;

      case BASE_ITEM_WHIP:
          return FEAT_WEAPON_PROFICIENCY_WHIP;

      case BASE_ITEM_ELF_LIGHTBLADE:
          return FEAT_WEAPON_PROFICIENCY_ELVEN_LIGHTBLADE;

      case BASE_ITEM_ELF_THINBLADE:
          return FEAT_WEAPON_PROFICIENCY_ELVEN_THINBLADE;

      case BASE_ITEM_ELF_COURTBLADE:
          return FEAT_WEAPON_PROFICIENCY_ELVEN_COURTBLADE;

      default:
          return FEAT_WEAPON_PROFICIENCY_SIMPLE;
      }

      return 0;
}

//resolves Weapon Prof feats to their ItemProp counterparts
int GetWeaponProfIPFeat(int nWeaponProfFeat)
{
    return nWeaponProfFeat - 3300;
}

//handles the feat chain for Elven Lightblades
void DoEquipLightblade(object oPC, object oItem, int nHand)
{
  if(DEBUG) DoDebug("Checking Lightblade feats"); // optimised as some feats are prereq for others
  if(GetHasFeat(FEAT_WEAPON_FOCUS_SHORT_SWORD, oPC) || GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER, oPC))
  {
      SetCompositeAttackBonus(oPC, "LightbladeWF" + IntToString(nHand), 1, nHand);
        if(GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD, oPC) || GetHasFeat(FEAT_WEAPON_SPECIALIZATION_RAPIER, oPC))
        {
            SetCompositeDamageBonusT(oItem, "LightbladeWS", 2);
            if(GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_SHORTSWORD, oPC) || GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_RAPIER, oPC))
                SetCompositeDamageBonusT(oItem, "LightbladeEpicWS", 4);
        }
        if(GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_SHORTSWORD, oPC) || GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_RAPIER, oPC))
            SetCompositeAttackBonus(oPC, "LightbladeEpicWF" + IntToString(nHand), 2, nHand);
  }

  if(GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORT_SWORD, oPC) || GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER, oPC))
      IPSafeAddItemProperty(oItem, ItemPropertyKeen(), 99999.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
}

//handles the feat chain for Elven Thinblades
void DoEquipThinblade(object oPC, object oItem, int nHand)
{
  if(GetHasFeat(FEAT_WEAPON_FOCUS_LONG_SWORD, oPC) || GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER, oPC))
    {
      SetCompositeAttackBonus(oPC, "ThinbladeWF" + IntToString(nHand), 1, nHand);
        if(GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONG_SWORD, oPC) || GetHasFeat(FEAT_WEAPON_SPECIALIZATION_RAPIER, oPC))
        {
            SetCompositeDamageBonusT(oItem, "ThinbladeWS", 2);
            if(GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_LONGSWORD, oPC) || GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_RAPIER, oPC))
                SetCompositeDamageBonusT(oItem, "ThinbladeEpicWS", 4);
        }
        if(GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_LONGSWORD, oPC) || GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_RAPIER, oPC))
            SetCompositeAttackBonus(oPC, "ThinbladeEpicWF" + IntToString(nHand), 2, nHand);
    }
  if(GetHasFeat(FEAT_IMPROVED_CRITICAL_LONG_SWORD, oPC) || GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER, oPC))
      IPSafeAddItemProperty(oItem, ItemPropertyKeen(), 99999.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
}

//handles the feat chain for Elven Courtblades
void DoEquipCourtblade(object oPC, object oItem, int nHand)
{
  if(GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_SWORD, oPC))
    {
      SetCompositeAttackBonus(oPC, "CourtbladeWF" + IntToString(nHand), 1, nHand);
        if(GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD, oPC))
        {
            SetCompositeDamageBonusT(oItem, "CourtbladeWS", 2);
            if(GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_GREATSWORD, oPC))
                SetCompositeDamageBonusT(oItem, "CourtbladeEpicWS", 4);
        }
        if(GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_GREATSWORD, oPC))
            SetCompositeAttackBonus(oPC, "CourtbladeEpicWF" + IntToString(nHand), 2, nHand);
    }
  if(GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_SWORD, oPC))
      IPSafeAddItemProperty(oItem, ItemPropertyKeen(), 99999.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
}

//clears any bonuses used to simulate feat chains on unequip
void DoWeaponFeatUnequip(object oPC, object oItem, int nHand)
{
    // fluffyamoeba - going to assume redundant local var clearing isn't worth tradeoff
  if(GetBaseItemType(oItem) == BASE_ITEM_ELF_LIGHTBLADE)
  {
      if(DEBUG) DoDebug("Clearing Lightblade variables.");
      SetCompositeAttackBonus(oPC, "LightbladeWF" + IntToString(nHand), 0, nHand);
      SetCompositeAttackBonus(oPC, "LightbladeEpicWF" + IntToString(nHand), 0, nHand);
      SetCompositeDamageBonusT(oItem, "LightbladeWS", 0);
      SetCompositeDamageBonusT(oItem, "LightbladeEpicWS", 0);
        if(GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORT_SWORD, oPC) || GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER, oPC))
            RemoveSpecificProperty(oItem, ITEM_PROPERTY_KEEN, -1, -1, 1, "", -1, DURATION_TYPE_TEMPORARY);
  }
  else if(GetBaseItemType(oItem) == BASE_ITEM_ELF_THINBLADE)
  {
      SetCompositeAttackBonus(oPC, "ThinbladeWF" + IntToString(nHand), 0, nHand);
      SetCompositeAttackBonus(oPC, "ThinbladeEpicWF" + IntToString(nHand), 0, nHand);
      SetCompositeDamageBonusT(oItem, "ThinbladeWS", 0);
      SetCompositeDamageBonusT(oItem, "ThinbladeEpicWS", 0);
        if(GetHasFeat(FEAT_IMPROVED_CRITICAL_LONG_SWORD, oPC) || GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER, oPC))
            RemoveSpecificProperty(oItem, ITEM_PROPERTY_KEEN, -1, -1, 1, "", -1, DURATION_TYPE_TEMPORARY);
  }
  else if(GetBaseItemType(oItem) == BASE_ITEM_ELF_COURTBLADE)
  {
      SetCompositeAttackBonus(oPC, "CourtbladeWF" + IntToString(nHand), 0, nHand);
      SetCompositeAttackBonus(oPC, "CourtbladeEpicWF" + IntToString(nHand), 0, nHand);
      SetCompositeDamageBonusT(oItem, "CourtbladeWS", 0);
      SetCompositeDamageBonusT(oItem, "CourtbladeEpicWS", 0);
        if(GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_SWORD, oPC))
            RemoveSpecificProperty(oItem, ITEM_PROPERTY_KEEN, -1, -1, 1, "", -1, DURATION_TYPE_TEMPORARY);
  }
}

int IsWeaponMartial(int nBaseItemType, object oPC)
{
  switch(nBaseItemType)
  {
      case BASE_ITEM_SHORTSWORD:
      case BASE_ITEM_LONGSWORD:
      case BASE_ITEM_BATTLEAXE:
      case BASE_ITEM_LIGHTFLAIL:
      case BASE_ITEM_WARHAMMER:
      case BASE_ITEM_LONGBOW:
      case BASE_ITEM_HALBERD:
      case BASE_ITEM_SHORTBOW:
      case BASE_ITEM_GREATSWORD:
      case BASE_ITEM_GREATAXE:
      case BASE_ITEM_HEAVYFLAIL:
      case BASE_ITEM_LIGHTHAMMER:
      case BASE_ITEM_HANDAXE:
      case BASE_ITEM_RAPIER:
      case BASE_ITEM_SCIMITAR:
      case BASE_ITEM_THROWINGAXE:
           return TRUE;

      //special case: counts as martial for dwarves
      case BASE_ITEM_DWARVENWARAXE:
          if(GetHasFeat(FEAT_DWARVEN, oPC))
            return TRUE;

      default:
           return FALSE;
  }
  return FALSE;
}

//checks to see if the PC can wield the weapon.  If not, applies a -4 penalty.
void DoProficiencyCheck(object oPC, object oItem, int nHand)
{
  int bProficient = FALSE;
  // minor optimisation - can return as soon as bProficient is true
  if(!GetIsWeapon(oItem)) return;

  if(GetTag(oItem) == "prc_eldrtch_glv") return;
  if(GetTag(oItem) == "PRC_PYRO_LASH_WHIP") return;

  bProficient = IsProficient(oPC, GetBaseItemType(oItem));

  if(!bProficient) SetCompositeAttackBonus(oPC, "Unproficient" + IntToString(nHand), -4, nHand);
}

void DoWeaponEquip(object oPC, object oItem, int nHand)
{
    if(GetIsDM(oPC)) return;

    //initialize variables
    int nRealSize = PRCGetCreatureSize(oPC);  //size for Finesse/TWF
    int nSize = nRealSize;                    //size for equipment restrictions
    int nWeaponSize = GetWeaponSize(oItem);
  if(GetTag(oItem) == "prc_eldrtch_glv") nWeaponSize = nRealSize + 1; //fix for eldritch glaive size
    int nDexMod = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
    int nStrMod = GetAbilityModifier(ABILITY_STRENGTH, oPC);
    int nElfFinesse = nDexMod - nStrMod;
    int nTHFDmgBonus = nStrMod / 2;

    //Powerful Build bonus
    if(GetHasFeat(FEAT_RACE_POWERFUL_BUILD, oPC))
        nSize++;

    if(DEBUG) DoDebug("prc_restwpnsize - Weapon size: " + IntToString(GetWeaponSize(oItem)));
    if(DEBUG) DoDebug("prc_restwpnsize - Character Size: " + IntToString(nSize));

    //check to make sure it's not too large, or that you're not trying to TWF with 2-handers
    if((nWeaponSize > 1 + nSize && nHand == ATTACK_BONUS_ONHAND) || ((nWeaponSize > nSize || GetWeaponSize(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)) > nSize) && nHand == ATTACK_BONUS_OFFHAND))
    {
        if(DEBUG) DoDebug("prc_restwpnsize: Forcing unequip due to size");
        if(nHand == ATTACK_BONUS_OFFHAND)
                nHand = INVENTORY_SLOT_LEFTHAND;
        else
                nHand = INVENTORY_SLOT_RIGHTHAND;
        // Force unequip
        ForceUnequip(oPC, oItem, nHand);
    }

    //check for proficiency
    DoProficiencyCheck(oPC, oItem, nHand);

    //simulate Weapon Finesse for Elven *blades
    if((GetBaseItemType(oItem) == BASE_ITEM_ELF_LIGHTBLADE || GetBaseItemType(oItem) == BASE_ITEM_ELF_THINBLADE 
       || GetBaseItemType(oItem) == BASE_ITEM_ELF_COURTBLADE) && GetHasFeat(FEAT_WEAPON_FINESSE, oPC) && nElfFinesse > 0)
    {
      if(nHand == ATTACK_BONUS_ONHAND)
            SetCompositeAttackBonus(oPC, "ElfFinesseRH", nElfFinesse, nHand);
      else if(nHand == ATTACK_BONUS_OFFHAND)
            SetCompositeAttackBonus(oPC, "ElfFinesseLH", nElfFinesse, nHand);
    }
    //Two-hand damage bonus
    if(!GetWeaponRanged(oItem) && (nWeaponSize == nSize + 1 || (nWeaponSize == nRealSize + 1 && GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) == OBJECT_INVALID) && nRealSize > CREATURE_SIZE_SMALL))
    {
        nTHFDmgBonus += IPGetWeaponEnhancementBonus(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS, FALSE);//include temp effects here
        if(DEBUG) DoDebug("Applying THF damage bonus");
        SetCompositeDamageBonusT(oItem, "THFBonus", nTHFDmgBonus);
    }

    //if a 2-hander, then unequip shield/offhand weapon
    if(nWeaponSize == 1 + nSize && nHand == ATTACK_BONUS_ONHAND)
        // Force unequip
        ForceUnequip(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC), INVENTORY_SLOT_LEFTHAND);


    //apply TWF penalty if a one-handed, not light weapon in offhand - -4/-4 etc isntead of -2/-2
    //Does not apply to small races due to weapon size-up. Stupid size equip hardcoded restrictions.
    if(nWeaponSize == nRealSize && nHand == ATTACK_BONUS_OFFHAND && nRealSize > CREATURE_SIZE_MEDIUM)
        // Assign penalty
        SetCompositeAttackBonus(oPC, "OTWFPenalty", -2);

    //Handle feat bonuses for Lightblade, thinblade, and courtblade
    //using else if so they don't overlap.
    if(GetBaseItemType(oItem) == BASE_ITEM_ELF_LIGHTBLADE)
        DoEquipLightblade(oPC, oItem, nHand);
    else if(GetBaseItemType(oItem) == BASE_ITEM_ELF_THINBLADE)
        DoEquipThinblade(oPC, oItem, nHand);
    else if(GetBaseItemType(oItem) == BASE_ITEM_ELF_COURTBLADE)
        DoEquipCourtblade(oPC, oItem, nHand);
}

void DoWeaponsEquip(object oPC)
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    DelayCommand(0.2, DoWeaponEquip(oPC, oWeapon, ATTACK_BONUS_ONHAND));
    oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if(!GetIsShield(oWeapon))
        DelayCommand(0.2, DoWeaponEquip(oPC, oWeapon, ATTACK_BONUS_OFFHAND));
}
