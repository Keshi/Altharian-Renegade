//::///////////////////////////////////////////////
//:: [PRC Feat Router]
//:: [inc_prc_function.nss]
//:://////////////////////////////////////////////
//:: This file serves as a hub for the various
//:: PRC passive feat functions.  If you need to
//:: add passive feats for a new PRC, link them here.
//::
//:: This file also contains a few multi-purpose
//:: PRC functions that need to be included in several
//:: places, ON DIFFERENT PRCS. Make local include files
//:: for any functions you use ONLY on ONE PRC.
//:://////////////////////////////////////////////
//:: Created By: Aaon Graywolf
//:: Created On: Dec 19, 2003
//:://////////////////////////////////////////////

//--------------------------------------------------------------------------
// This is the "event" that is called to re-evalutate PRC bonuses.  Currently
// it is fired by OnEquip, OnUnequip and OnLevel.  If you want to move any
// classes into this event, just copy the format below.  Basically, this function
// is meant to keep the code looking nice and clean by routing each class's
// feats to their own self-contained script
//--------------------------------------------------------------------------

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const int TEMPLATE_SLA_START = 16304;
const int TEMPLATE_SLA_END   = 16400;

const string PRC_ScrubPCSkin_Generation = "PRC_ScrubPCSkin_Generation";
const string PRC_DeletePRCLocalInts_Generation = "PRC_DeletePRCLocalInts_Generation";
const string PRC_EvalPRCFeats_Generation = "PRC_EvalPRCFeats_Generation";

//////////////////////////////////////////////////
/*                 Includes                     */
//////////////////////////////////////////////////

#include "prc_inc_util"

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

void EvalPRCFeats(object oPC);

int BlastInfidelOrFaithHeal(object oCaster, object oTarget, int iEnergyType, int iDisplayFeedback);

void ScrubPCSkin(object oPC, object oSkin);

void DeletePRCLocalInts(object oSkin);

void DelayedAddIPFeats(int nExpectedGeneration, object oPC);

void DelayedBonusDomainCheck(int nExpectedGeneration, object oPC);

void DelayedTemplateSLAs(int nExpectedGeneration, object oPC);

void DelayedReApplyUnhealableAbilityDamage(int nExpectedGeneration, object oPC);

int nbWeaponFocus(object oPC);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

// Minimalist includes

#include "prc_inc_spells"
#include "prc_inc_stunfist"

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

string GetClassScriptFile(int iClassType)
{
    switch(iClassType)
    {
        case CLASS_TYPE_DUELIST:                      return "prc_duelist";
        case CLASS_TYPE_ACOLYTE:                      return "prc_acolyte";
        case CLASS_TYPE_SPELLSWORD:                   return "prc_spellswd";
        case CLASS_TYPE_MAGEKILLER:                   return "prc_magekill";
        case CLASS_TYPE_OOZEMASTER:                   return "prc_oozemstr";
        case CLASS_TYPE_DISCIPLE_OF_MEPH:             return "prc_discmeph";
        case CLASS_TYPE_LICH:                         return "pnp_lich_level";
        case CLASS_TYPE_ES_FIRE:
        case CLASS_TYPE_ES_COLD:
        case CLASS_TYPE_ES_ELEC:
        case CLASS_TYPE_ES_ACID:
        case CLASS_TYPE_DIVESF:
        case CLASS_TYPE_DIVESC:
        case CLASS_TYPE_DIVESE:
        case CLASS_TYPE_DIVESA:                       return "prc_elemsavant";
        case CLASS_TYPE_HEARTWARDER:                  return "prc_heartwarder";
        case CLASS_TYPE_STORMLORD:                    return "prc_stormlord";
        case CLASS_TYPE_PNP_SHIFTER :                 return "prc_shifter";
        case CLASS_TYPE_SOUL_EATER:                   return "prc_sleat";
        case CLASS_TYPE_SHINING_BLADE:                return "prc_sbheir";
        case CLASS_TYPE_FRE_BERSERKER:                return "prc_frebzk";
        case CLASS_TYPE_PRC_EYE_OF_GRUUMSH:           return "prc_eog";
        case CLASS_TYPE_TEMPEST:                      return "prc_tempest";
        case CLASS_TYPE_FOE_HUNTER:                   return "prc_foe_hntr";
        case CLASS_TYPE_VASSAL:                       return "prc_vassal";
        case CLASS_TYPE_PEERLESS:                     return "prc_peerless";
        case CLASS_TYPE_LEGENDARY_DREADNOUGHT:        return "prc_legendread";
        case CLASS_TYPE_DISC_BAALZEBUL:               return "prc_baalzebul";
        case CLASS_TYPE_IAIJUTSU_MASTER:              return "prc_iaijutsu_mst";
        case CLASS_TYPE_FISTRAZIEL:                   return "prc_fistraziel";
        case CLASS_TYPE_SACREDFIST:                   return "prc_sacredfist";
        case CLASS_TYPE_ENLIGHTENEDFIST:              return "prc_enlfis";
        case CLASS_TYPE_INITIATE_DRACONIC:            return "prc_initdraconic";
        case CLASS_TYPE_BLADESINGER:                  return "prc_bladesinger";
        case CLASS_TYPE_HEXTOR:                       return "prc_hextor";
        case CLASS_TYPE_BOWMAN:                       return "prc_bowman";
        case CLASS_TYPE_TEMPUS:                       return "prc_battletempus";
        case CLASS_TYPE_DISPATER:                     return "prc_dispater";
        case CLASS_TYPE_MANATARMS:                    return "prc_manatarms";
        case CLASS_TYPE_SOLDIER_OF_LIGHT:             return "prc_soldoflight";
        case CLASS_TYPE_HENSHIN_MYSTIC:               return "prc_henshin";
        case CLASS_TYPE_DRUNKEN_MASTER:               return "prc_drunk";
        case CLASS_TYPE_MASTER_HARPER:                return "prc_masterh";
        case CLASS_TYPE_SHOU:                         return "prc_shou";
        case CLASS_TYPE_BFZ:                          return "prc_bfz";
        case CLASS_TYPE_BONDED_SUMMONNER:             return "prc_bondedsumm";
        case CLASS_TYPE_SHADOW_ADEPT:                 return "prc_shadowadept";
        case CLASS_TYPE_BRAWLER:                      return "prc_brawler";
        case CLASS_TYPE_MINSTREL_EDGE:                return "prc_minstrel";
        case CLASS_TYPE_NIGHTSHADE:                   return "prc_nightshade";
        case CLASS_TYPE_RUNESCARRED:                  return "prc_runescarred";
        case CLASS_TYPE_ULTIMATE_RANGER:              return "prc_uranger";
        case CLASS_TYPE_WEREWOLF:                     return "prc_werewolf";
        case CLASS_TYPE_JUDICATOR:                    return "prc_judicator";
        case CLASS_TYPE_ARCANE_DUELIST:               return "prc_arcduel";
        case CLASS_TYPE_THAYAN_KNIGHT:                return "prc_thayknight";
        case CLASS_TYPE_TEMPLE_RAIDER:                return "prc_templeraider";
        case CLASS_TYPE_BLARCHER:                     return "prc_bld_arch";
        case CLASS_TYPE_OUTLAW_CRIMSON_ROAD:          return "prc_outlawroad";
        case CLASS_TYPE_ALAGHAR:                      return "prc_alaghar";
        case CLASS_TYPE_KNIGHT_CHALICE:               return "prc_knghtch";
        case CLASS_TYPE_THRALL_OF_GRAZZT_A:
        case CLASS_TYPE_THRALL_OF_GRAZZT_D:           return "tog";
        case CLASS_TYPE_BLIGHTLORD:                   return "prc_blightlord";
        case CLASS_TYPE_FIST_OF_ZUOKEN:               return "psi_zuoken";
        case CLASS_TYPE_NINJA:                        return "prc_ninjca";
        case CLASS_TYPE_OLLAM:                        return "prc_ollam";
        case CLASS_TYPE_COMBAT_MEDIC:                 return "prc_cbtmed";
        case CLASS_TYPE_DRAGON_DISCIPLE:              return "prc_dradis";
        case CLASS_TYPE_HALFLING_WARSLINGER:          return "prc_warsling";
        case CLASS_TYPE_BAELNORN:                     return "prc_baelnorn";
        case CLASS_TYPE_SWASHBUCKLER:                 return "prc_swashbuckler";
        case CLASS_TYPE_CONTEMPLATIVE:                return "prc_contemplate";
        case CLASS_TYPE_BLOOD_MAGUS:                  return "prc_bloodmagus";
        case CLASS_TYPE_LASHER:                       return "prc_lasher";
        case CLASS_TYPE_WARCHIEF:                     return "prc_warchief";
        case CLASS_TYPE_GHOST_FACED_KILLER:           return "prc_gfkill";
        case CLASS_TYPE_WARMIND:                      return "psi_warmind";
        case CLASS_TYPE_IRONMIND:                     return "psi_ironmind";
        case CLASS_TYPE_SANCTIFIED_MIND:              return "psi_sancmind";
        case CLASS_TYPE_ORDER_BOW_INITIATE:           return "prc_ootbi";
        case CLASS_TYPE_SLAYER_OF_DOMIEL:             return "prc_slayerdomiel";
        case CLASS_TYPE_DISCIPLE_OF_ASMODEUS:         return "prc_discasmodeus";
        case CLASS_TYPE_THRALLHERD:                   return "psi_thrallherd";
        case CLASS_TYPE_SOULKNIFE:                    return "psi_sk_clseval";
        case CLASS_TYPE_MIGHTY_CONTENDER_KORD:        return "prc_contendkord";
      //case CLASS_TYPE_SUEL_ARCHANAMACH:             return "prc_suelarchana";
        case CLASS_TYPE_FAVOURED_SOUL:                return "prc_favouredsoul";
        case CLASS_TYPE_SHADOWBLADE:                  return "prc_sb_shdstlth";
        case CLASS_TYPE_CW_SAMURAI:                   return "prc_cwsamurai";
        case CLASS_TYPE_SKULLCLAN_HUNTER:             return "prc_skullclan";
      //case CLASS_TYPE_HEXBLADE:                     return "prc_hexblade";
        case CLASS_TYPE_TRUENAMER:                    return "true_truenamer";
        case CLASS_TYPE_DUSKBLADE:                    return "prc_duskblade";
        case CLASS_TYPE_SCOUT:                        return "prc_scout";
      //case CLASS_TYPE_WARMAGE:                      return "prc_warmage";
        case CLASS_TYPE_KNIGHT:                       return "prc_knight";
        case CLASS_TYPE_SHADOWMIND:                   return "psi_shadowmind";
        case CLASS_TYPE_COC:                          return "prc_coc";
        case CLASS_TYPE_DIAMOND_DRAGON:               return "psi_diadra";
        case CLASS_TYPE_SWIFT_WING:                   return "prc_swiftwing";
        case CLASS_TYPE_DRAGON_DEVOTEE:               return "prc_dragdev";
        case CLASS_TYPE_TALON_OF_TIAMAT:              return "prc_talontiamat";
        case CLASS_TYPE_DRAGON_SHAMAN:                return "prc_dragonshaman";
        case CLASS_TYPE_PYROKINETICIST:               return "psi_pyro";
        case CLASS_TYPE_DRAGONFIRE_ADEPT:             return "inv_drgnfireadpt";
        case CLASS_TYPE_SHAMAN:                       return "prc_shaman";
        case CLASS_TYPE_SWORDSAGE:                    return "tob_swordsage";
        case CLASS_TYPE_DEEPSTONE_SENTINEL:           return "tob_deepstone";
        case CLASS_TYPE_CRUSADER:                     return "tob_crusader";
        case CLASS_TYPE_WARBLADE:                     return "tob_warblade";
        case CLASS_TYPE_JADE_PHOENIX_MAGE:            return "tob_jadephoenix";
        case CLASS_TYPE_WARLOCK:                      return "inv_warlock";
        case CLASS_TYPE_BLOODCLAW_MASTER:             return "tob_bloodclaw";
        case CLASS_TYPE_ETERNAL_BLADE:                return "tob_eternalblade";
        case CLASS_TYPE_SHADOW_SUN_NINJA:             return "tob_shadowsun";
        case CLASS_TYPE_DREAD_NECROMANCER:            return "prc_dreadnecro";
        case CLASS_TYPE_MORNINGLORD:                  return "prc_morninglord";
        case CLASS_TYPE_VIGILANT:                     return "prc_vigilant";
        case CLASS_TYPE_ALIENIST:                     return "prc_alienist";
        case CLASS_TYPE_RAGE_MAGE:                    return "prc_ragemage";
        case CLASS_TYPE_SUBLIME_CHORD:                return "prc_schord";
        case CLASS_TYPE_ARCHIVIST:                    return "prc_archivist";
        case CLASS_TYPE_DRUID:                        return "prc_druid";
    }
    return "";
}

void DelayedExecuteScript(int nExpectedGeneration, string sScriptName, object oPC)
{
    if (nExpectedGeneration != GetLocalInt(oPC, PRC_EvalPRCFeats_Generation))
    {
        //Generation has changed, so don't apply the effect
        return;
    }
    ExecuteScript(sScriptName, oPC);
}

void DelayedReApplyUnhealableAbilityDamage(int nExpectedGeneration, object oPC)
{
    if (nExpectedGeneration != GetLocalInt(oPC, PRC_ScrubPCSkin_Generation))
    {
        //Generation has changed, so don't apply the effect
        return;
    }
    ReApplyUnhealableAbilityDamage(oPC);
}

void EvalPRCFeats(object oPC)
{
    int nGeneration = PRC_NextGeneration(GetLocalInt(oPC, PRC_EvalPRCFeats_Generation));
    if (DEBUG > 1) DoDebug("EvalPRCFeats Generation: " + IntToString(nGeneration));
    SetLocalInt(oPC, PRC_EvalPRCFeats_Generation, nGeneration);

    //Add IP Feats to the hide
    DelayCommand(0.0f, DelayedAddIPFeats(nGeneration, oPC));

    //check bonus domains
    DelayCommand(0.1f, DelayedBonusDomainCheck(nGeneration, oPC));

    // special add atk bonus equal to Enhancement
    ExecuteScript("ft_sanctmartial", oPC);

    //hook in the weapon size restrictions script
    ExecuteScript("prc_restwpnsize", oPC);

    //Route the event to the appropriate class specific scripts
    int i;
    for (i = 1; i <= 3; i++)
    {
        int nClassType = GetClassByPosition(i, oPC);
        if (nClassType != CLASS_TYPE_INVALID)
        {
            string sScript = GetClassScriptFile(nClassType);
            if (sScript == "")
                continue;

            //Optimize? Don't run scripts unless they need to be called.
            /*int nClassLevel = GetLevelByPosition(i, oPC);
            switch(nClassType)
            {
                case CLASS_TYPE_VIGILANT:    if (nClassLevel < 9) continue;
                case CLASS_TYPE_ALIENIST:
                case CLASS_TYPE_SHADOWBLADE: if (nClassLevel < 2) continue;
            }*/
            ExecuteScript(sScript, oPC);
        }
    }

    // Templates
    //these go here so feats can be reused
    ExecuteScript("prc_templates", oPC);

    // Feats
    //these are here so if templates add them the if check runs after the template was applied
    ExecuteScript("prc_feats", oPC);

    // Add the teleport management feats.
    // 2005.11.03: Now added to all base classes on 1st level - Ornedan
//    ExecuteScript("prc_tp_mgmt_eval", oPC);

    // Size changes
    int nLastSize = GetLocalInt(oPC, "PRCLastSize") + CREATURE_SIZE_FINE - 1;
    int nPRCSize = PRCGetCreatureSize(oPC);
    if(nPRCSize != nLastSize)
        ExecuteScript("prc_size", oPC);

    // Speed changes
    ExecuteScript("prc_speed", oPC);

    // ACP system
    if((GetIsPC(oPC) &&
        (GetPRCSwitch(PRC_ACP_MANUAL)   ||
         GetPRCSwitch(PRC_ACP_AUTOMATIC)
         )
        ) ||
       (!GetIsPC(oPC) &&
        GetPRCSwitch(PRC_ACP_NPC_AUTOMATIC)
        )
       )
        ExecuteScript("acp_auto", oPC);

// this is handled inside the PRC Options conversation now.
/*    // Epic spells
    if((GetCasterLvl(CLASS_TYPE_CLERIC,   oPC) >= 21 ||
        GetCasterLvl(CLASS_TYPE_DRUID,    oPC) >= 21 ||
        GetCasterLvl(CLASS_TYPE_SORCERER, oPC) >= 21 ||
        GetCasterLvl(CLASS_TYPE_FAVOURED_SOUL, oPC) >= 21 ||
        GetCasterLvl(CLASS_TYPE_HEALER, oPC) >= 21 ||
        GetCasterLvl(CLASS_TYPE_WIZARD,   oPC) >= 21
        ) &&
        !GetHasFeat(FEAT_EPIC_SPELLCASTING_REST, oPC)
       )
    {
        IPSafeAddItemProperty(oSkin, PRCItemPropertyBonusFeat(IP_CONST_FEAT_EPIC_REST), 0.0f,
                              X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
    }*/

    // Miscellaneous
    ExecuteScript("prc_sneak_att", oPC);
    ExecuteScript("race_skin", oPC);
    ExecuteScript("prc_mithral", oPC);
    if(GetPRCSwitch(PRC_ENFORCE_RACIAL_APPEARANCE) && GetIsPC(oPC))
        ExecuteScript("race_appear", oPC);

    //permanent ability bonuses
    if(GetPRCSwitch(PRC_NWNX_FUNCS))
        ExecuteScript("prc_nwnx_funcs", oPC);

    // Handle alternate caster types gaining new stuff
    if(// Psionics
       GetLevelByClass(CLASS_TYPE_PSION,            oPC) ||
       GetLevelByClass(CLASS_TYPE_WILDER,           oPC) ||
       GetLevelByClass(CLASS_TYPE_PSYWAR,           oPC) ||
       GetLevelByClass(CLASS_TYPE_FIST_OF_ZUOKEN,   oPC) ||
       GetLevelByClass(CLASS_TYPE_WARMIND,          oPC) ||
       // New spellbooks
       GetLevelByClass(CLASS_TYPE_BARD,             oPC) ||
       GetLevelByClass(CLASS_TYPE_SORCERER,         oPC) ||
       GetLevelByClass(CLASS_TYPE_SUEL_ARCHANAMACH, oPC) ||
       GetLevelByClass(CLASS_TYPE_FAVOURED_SOUL,    oPC) ||
       GetLevelByClass(CLASS_TYPE_MYSTIC,           oPC) ||
       GetLevelByClass(CLASS_TYPE_HEXBLADE,         oPC) ||
       GetLevelByClass(CLASS_TYPE_DUSKBLADE,        oPC) ||
       GetLevelByClass(CLASS_TYPE_WARMAGE,          oPC) ||
       GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER,oPC) ||
       GetLevelByClass(CLASS_TYPE_JUSTICEWW,        oPC) ||
       GetLevelByClass(CLASS_TYPE_WITCH,            oPC) ||
       GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD,    oPC) ||
       GetLevelByClass(CLASS_TYPE_ARCHIVIST,        oPC) ||
       GetLevelByClass(CLASS_TYPE_BEGUILER,         oPC) ||
       GetLevelByClass(CLASS_TYPE_HARPER,           oPC) ||
       GetLevelByClass(CLASS_TYPE_TEMPLAR,          oPC) ||
       // Truenaming
       GetLevelByClass(CLASS_TYPE_TRUENAMER,        oPC) ||
       // Tome of Battle
       GetLevelByClass(CLASS_TYPE_CRUSADER,         oPC) ||
       GetLevelByClass(CLASS_TYPE_SWORDSAGE,        oPC) ||
       GetLevelByClass(CLASS_TYPE_WARBLADE,         oPC) ||
       // Invocations
       GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oPC) ||
       GetLevelByClass(CLASS_TYPE_WARLOCK, oPC) ||
       // Racial casters
       (GetLevelByClass(CLASS_TYPE_OUTSIDER, oPC) && GetRacialType(oPC) == RACIAL_TYPE_RAKSHASA)
        )
      {
        DelayCommand(1.0, DelayedExecuteScript(nGeneration, "prc_amagsys_gain", oPC));

        //add selectable metamagic feats for spontaneous spellcasters
        ExecuteScript("prc_metamagic", oPC);
      }

    // Gathers all the calls to UnarmedFists & Feats to one place.
    // Must be after all evaluationscripts that need said functions.
    if(GetLocalInt(oPC, "CALL_UNARMED_FEATS") || GetLocalInt(oPC, "CALL_UNARMED_FISTS")) // ExecuteScript() is pretty expensive, do not run it needlessly - 20060702, Ornedan
        ExecuteScript("unarmed_caller", oPC);

    // Gathers all the calls to SetBaseAttackBonus() to one place
    // Must be after all evaluationscripts that need said function.
    ExecuteScript("prc_bab_caller", oPC);

    // Classes an invoker can take
    if(GetLevelByClass(CLASS_TYPE_MAESTER,              oPC) ||
       GetLevelByClass(CLASS_TYPE_ACOLYTE,              oPC) ||
       GetLevelByClass(CLASS_TYPE_ENLIGHTENEDFIST,      oPC) ||
       GetLevelByClass(CLASS_TYPE_DISCIPLE_OF_ASMODEUS, oPC))
       {
           //Set arcane or invocation bonus caster levels

           //Arcane caster first class position, take arcane
           if(GetFirstArcaneClassPosition(oPC) == 1)
               SetLocalInt(oPC, "INV_Caster", 1);
           //Invoker first class position. take invoker
           else if(GetClassByPosition(1, oPC) == CLASS_TYPE_WARLOCK || GetClassByPosition(1, oPC) == CLASS_TYPE_DRAGONFIRE_ADEPT)
               SetLocalInt(oPC, "INV_Caster", 2);
           //Non arcane first class position, invoker second.  Take invoker
           else if(GetFirstArcaneClassPosition(oPC) ==0 && (GetClassByPosition(2, oPC) == CLASS_TYPE_WARLOCK || GetClassByPosition(2, oPC) == CLASS_TYPE_DRAGONFIRE_ADEPT))
               SetLocalInt(oPC, "INV_Caster", 2);
           //last cas would be Non-invoker first class position, arcane second position. take arcane.
           else
               SetLocalInt(oPC, "INV_Caster", 1);
       }
}

void DelayedAddIPFeats(int nExpectedGeneration, object oPC)
{
    if (nExpectedGeneration != GetLocalInt(oPC, PRC_EvalPRCFeats_Generation))
    {
        //Generation has changed, so don't apply the effect
        return;
    }

    object oSkin = GetPCSkin(oPC);

    // Switch convo feat
    //Now everyone gets it at level 1, but just to be on the safe side
    if(!GetHasFeat(FEAT_OPTIONS_CONVERSATION, oPC))
        IPSafeAddItemProperty(oSkin, PRCItemPropertyBonusFeat(229), 0.0f, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

    //PnP familiars
    if(GetHasFeat(FEAT_SUMMON_FAMILIAR, oPC) && GetPRCSwitch(PRC_PNP_FAMILIARS))
        IPSafeAddItemProperty(oSkin, PRCItemPropertyBonusFeat(IP_CONST_PNP_FAMILIAR), 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
    else if(!GetHasFeat(FEAT_SUMMON_FAMILIAR, oPC) || !GetPRCSwitch(PRC_PNP_FAMILIARS))
        RemoveItemProperty(oSkin, ItemPropertyBonusFeat(IP_CONST_PNP_FAMILIAR));

    //PnP Spell Schools
    if(GetPRCSwitch(PRC_PNP_SPELL_SCHOOLS)
        && GetLevelByClass(CLASS_TYPE_WIZARD, oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_GENERAL,       oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_ABJURATION,    oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_CONJURATION,   oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_DIVINATION,    oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_ENCHANTMENT,   oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_EVOCATION,     oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_ILLUSION,      oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_NECROMANCY,    oPC)
        && !GetHasFeat(FEAT_PNP_SPELL_SCHOOL_TRANSMUTATION, oPC)
        && !GetIsPolyMorphedOrShifted(oPC)
        //&& !PRCGetHasEffect(EFFECT_TYPE_POLYMORPH, oPC) //so it doesnt pop up on polymorphing
        //&& !GetLocalInt(oSkin, "nPCShifted") //so it doenst pop up on shifting
        )
    {
        ExecuteScript("prc_pnp_shcc_s", oPC);
    }

    /*//Arcane Archer old imbue arrow
    if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC) >= 2
        && !GetHasFeat(FEAT_PRESTIGE_IMBUE_ARROW, oPC)
        && GetPRCSwitch(PRC_PNP_SPELL_SCHOOLS))
    {
        //add the old feat to the hide
        IPSafeAddItemProperty(oSkin, PRCItemPropertyBonusFeat(IP_CONST_FEAT_FEAT_PRESTIGE_IMBUE_ARROW), 0.0f,
                              X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
    }*/

    //handle PnP sling switch
    if(GetPRCSwitch(PRC_PNP_SLINGS))
    {
        if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)) == BASE_ITEM_SLING)
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC),
                ItemPropertyMaxRangeStrengthMod(20),
                999999.9);
    }
}

void DelayedBonusDomainCheck(int nExpectedGeneration, object oPC)
{
    if (nExpectedGeneration != GetLocalInt(oPC, PRC_EvalPRCFeats_Generation))
    {
        //Generation has changed, so don't apply the effect
        return;
    }

    // If there is a bonus domain, it will always be in the first slot, so just check that.
    // It also runs things that clerics with those domains need
    if (GetPersistantLocalInt(oPC, "PRCBonusDomain1") > 0 || GetLevelByClass(CLASS_TYPE_CLERIC, oPC))
        ExecuteScript("prc_domain_skin", oPC);
}

void DelayedTemplateSLAs(int nExpectedGeneration, object oPC)
{
    if (nExpectedGeneration != GetLocalInt(oPC, PRC_DeletePRCLocalInts_Generation))
    {
        //Generation has changed, so don't apply the effect
        return;
    }
    int i;
    for(i = TEMPLATE_SLA_START; i <= TEMPLATE_SLA_END; i++)
    {
        DeleteLocalInt(oPC, "TemplateSLA_"+IntToString(i));
    }
}

void DeletePRCLocalInts(object oSkin)
{
    int nGeneration = PRC_NextGeneration(GetLocalInt(oSkin, PRC_DeletePRCLocalInts_Generation));
    if (DEBUG > 1) DoDebug("DeletePRCLocalInts Generation: " + IntToString(nGeneration));
    SetLocalInt(oSkin, PRC_DeletePRCLocalInts_Generation, nGeneration);

    // This will get rid of any SetCompositeAttackBonus LocalInts:
    object oPC = GetItemPossessor(oSkin);
    DeleteLocalInt(oPC, "CompositeAttackBonusR");
    DeleteLocalInt(oPC, "CompositeAttackBonusL");

    //Do not use DelayCommand for this--it's too dangerous:
    //if SetCompositeAttackBonus is called at the wrong time the result will be incorrect.
    DeleteNamedComposites(oPC, "PRC_ComAttBon");

    // PRCGetClassByPosition and PRCGetLevelByPosition cleanup
    // not needed now that GetClassByPosition() works for custom classes
    // DeleteLocalInt(oPC, "PRC_ClassInPos1");
    // DeleteLocalInt(oPC, "PRC_ClassInPos2");
    // DeleteLocalInt(oPC, "PRC_ClassInPos3");
    // DeleteLocalInt(oPC, "PRC_ClassLevelInPos1");
    // DeleteLocalInt(oPC, "PRC_ClassLevelInPos2");
    // DeleteLocalInt(oPC, "PRC_ClassLevelInPos3");

    //persistant local token object cache
    //looks like logging off then back on without the server rebooting breaks it
    //I guess because the token gets a new ID, but the local still points to the old one
    DeleteLocalObject(oPC, "PRC_HideTokenCache");

    // In order to work with the PRC system we need to delete some locals for each
    // PRC that has a hide

    //Do not use DelayCommand for this--it's too dangerous:
    //if SetCompositeBonus is called between the time EvalPRCFeats removes item properties
    //and the time this delayed command is executed, the result will be incorrect.
    //Since this error case actually happens frequently with any delay here, just don't do it.
    DeleteNamedComposites(oSkin, "PRC_CBon");

    if (DEBUG) DoDebug("Clearing class flags");

    // Elemental Savants
    DeleteLocalInt(oSkin,"ElemSavantResist");
    DeleteLocalInt(oSkin,"ElemSavantPerfection");
    DeleteLocalInt(oSkin,"ElemSavantImmMind");
    DeleteLocalInt(oSkin,"ElemSavantImmParal");
    DeleteLocalInt(oSkin,"ElemSavantImmSleep");
    // HeartWarder
    DeleteLocalInt(oSkin,"FeyType");
    // OozeMaster
    DeleteLocalInt(oSkin,"IndiscernibleCrit");
    DeleteLocalInt(oSkin,"IndiscernibleBS");
    DeleteLocalInt(oSkin,"OneOozeMind");
    DeleteLocalInt(oSkin,"OneOozePoison");
    // Storm lord
    DeleteLocalInt(oSkin,"StormLResElec");
    // Spell sword
    DeleteLocalInt(oSkin,"SpellswordSFBonusNormal");
    DeleteLocalInt(oSkin,"SpellswordSFBonusEpic");
    // Acolyte of the skin
    DeleteLocalInt(oSkin,"AcolyteSymbBonus");
    DeleteLocalInt(oSkin,"AcolyteResistanceCold");
    DeleteLocalInt(oSkin,"AcolyteResistanceFire");
    DeleteLocalInt(oSkin,"AcolyteResistanceAcid");
    DeleteLocalInt(oSkin,"AcolyteResistanceElectric");
    // Battleguard of Tempus
    DeleteLocalInt(oSkin,"FEAT_WEAP_TEMPUS");
    // Bonded Summoner
    DeleteLocalInt(oSkin,"BondResEle");
    DeleteLocalInt(oSkin,"BondSubType");
    // Disciple of Meph
    DeleteLocalInt(oSkin,"DiscMephResist");
    DeleteLocalInt(oSkin,"DiscMephGlove");
    // Initiate of Draconic Mysteries
    DeleteLocalInt(oSkin,"IniSR");
    DeleteLocalInt(oSkin,"IniStunStrk");
    // Man at Arms
    DeleteLocalInt(oSkin,"ManArmsCore");
    // Telflammar Shadowlord
    DeleteLocalInt(oSkin,"ShaDiscorp");
    // Vile Feats
    DeleteLocalInt(oSkin,"DeformGaunt");
    DeleteLocalInt(oSkin,"DeformObese");
    // Sneak Attack
    DeleteLocalInt(oSkin,"RogueSneakDice");
    DeleteLocalInt(oSkin,"BlackguardSneakDice");
    // Sacred Fist
    DeleteLocalInt(oSkin,"SacFisMv");
    // Minstrel
    DeleteLocalInt(oSkin,"MinstrelSFBonus"); /// @todo Make ASF reduction compositable
    // Nightshade
    DeleteLocalInt(oSkin,"ImmuNSWeb");
    DeleteLocalInt(oSkin,"ImmuNSPoison");
    // Soldier of Light
    DeleteLocalInt(oSkin,"ImmuPF");
    // Ultimate Ranger
    DeleteLocalInt(oSkin,"URImmu");
    // Thayan Knight
    DeleteLocalInt(oSkin,"ThayHorror");
    DeleteLocalInt(oSkin,"ThayZulkFave");
    DeleteLocalInt(oSkin,"ThayZulkChamp");
    // Black Flame Zealot
    DeleteLocalInt(oSkin,"BFZHeart");
    // Henshin Mystic
    DeleteLocalInt(oSkin,"Happo");
    DeleteLocalInt(oSkin,"HMSight");
    DeleteLocalInt(oSkin,"HMInvul");
    //Blightlord
    DeleteLocalInt(oSkin, "WntrHeart");
    DeleteLocalInt(oSkin, "BlightBlood");
    // Contemplative
    DeleteLocalInt(oSkin, "ContempDisease");
    DeleteLocalInt(oSkin, "ContempPoison");
    DeleteLocalInt(oSkin, "ContemplativeDR");
    DeleteLocalInt(oSkin, "ContemplativeSR");
    // Dread Necromancer
    DeleteLocalInt(oSkin, "DNDamageResist");
    // Warsling Sniper
    DeleteLocalInt(oPC, "CanRicochet");
    // Blood Magus
    DeleteLocalInt(oSkin, "ThickerThanWater");

    // Feats
    DeleteLocalInt(oPC, "ForceOfPersonalityWis");
    DeleteLocalInt(oPC, "ForceOfPersonalityCha");
    DeleteLocalInt(oPC, "InsightfulReflexesInt");
    DeleteLocalInt(oPC, "InsightfulReflexesDex");
    DeleteLocalInt(oSkin, "TactileTrapsmithSearchIncrease");
    DeleteLocalInt(oSkin, "TactileTrapsmithDisableIncrease");
    DeleteLocalInt(oSkin, "TactileTrapsmithSearchDecrease");
    DeleteLocalInt(oSkin, "TactileTrapsmithDisableDecrease");

    // Warmind
    DeleteLocalInt(oSkin, "EnduringBody");

    // Ironmind
    DeleteLocalInt(oSkin, "IronMind_DR");

    // Suel Archanamach
    DeleteLocalInt(oSkin, "SuelArchanamachSpellFailure");

    // Favoured Soul
    DeleteLocalInt(oSkin, "FavouredSoulResistElementAcid");
    DeleteLocalInt(oSkin, "FavouredSoulResistElementCold");
    DeleteLocalInt(oSkin, "FavouredSoulResistElementElec");
    DeleteLocalInt(oSkin, "FavouredSoulResistElementFire");
    DeleteLocalInt(oSkin, "FavouredSoulResistElementSonic");

    // Domains
    DeleteLocalInt(oSkin, "StormDomainPower");

    // Skullclan Hunter
    DeleteLocalInt(oSkin, "SkullClanFear");
    DeleteLocalInt(oSkin, "SkullClanDisease");
    DeleteLocalInt(oSkin, "SkullClanProtectionEvil");
    DeleteLocalInt(oSkin, "SkullClanSwordLight");
    DeleteLocalInt(oSkin, "SkullClanParalysis");
    DeleteLocalInt(oSkin, "SkullClanAbilityDrain");
    DeleteLocalInt(oSkin, "SkullClanLevelDrain");

    // Hexblade
    DeleteLocalInt(oSkin, "HexbladeArmourCasting");

    // Sohei
    DeleteLocalInt(oSkin, "SoheiDamageResist");

    // Duskblade
    DeleteLocalInt(oSkin, "DuskbladeArmourCasting");

    //Warblade
    DeleteLocalInt(oSkin, "PRC_WEAPON_APTITUDE_APPLIED");

    //Shifter(PnP)
    DeleteLocalInt(oSkin, "PRC_SHIFTER_TEMPLATE_APPLIED");

    DeleteLocalInt(oPC, "ScoutFreeMove");
    DeleteLocalInt(oPC, "ScoutFastMove");
    DeleteLocalInt(oPC, "ScoutBlindsight");

    // Enlightened Fist
    DeleteLocalInt(oPC, "EnlightenedFistSR");

    //new skill focuses
    DeleteLocalInt(oSkin, "SkillFoc_Alchemy");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Alchemy");
    DeleteLocalInt(oSkin, "SkillFoc_Ride");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Ride");
    DeleteLocalInt(oSkin, "SkillFoc_Jump");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Jump");
    DeleteLocalInt(oSkin, "SkillFoc_SenseMotive");
    DeleteLocalInt(oSkin, "EpicSkillFoc_SenseMotive");
    DeleteLocalInt(oSkin, "SkillFoc_MartialLore");
    DeleteLocalInt(oSkin, "EpicSkillFoc_MartialLore");
    DeleteLocalInt(oSkin, "SkillFoc_Balance");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Balance");
    DeleteLocalInt(oSkin, "SkillFoc_CraftPoison");
    DeleteLocalInt(oSkin, "EpicSkillFoc_CraftPoison");
    DeleteLocalInt(oSkin, "SkillFoc_Psicraft");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Psicraft");
    DeleteLocalInt(oSkin, "SkillFoc_Climb");
    DeleteLocalInt(oSkin, "EpicSkillFoc_Climb");
    DeleteLocalInt(oSkin, "SkillFoc_CraftGeneral");
    DeleteLocalInt(oSkin, "EpicSkillFoc_CraftGeneral");

    //Truenamer
    int UtterID;
    for(UtterID = 3526; UtterID <= 3639; UtterID++) // All utterances
        DeleteLocalInt(oPC, "PRC_LawOfResistance" + IntToString(UtterID));
    for(UtterID = 3418; UtterID <= 3431; UtterID++) // Syllable of Detachment to Word of Heaven, Greater
        DeleteLocalInt(oPC, "PRC_LawOfResistance" + IntToString(UtterID));

    //clear Dragonfriend/Dragonthrall flag so effect properly reapplies
    DeleteLocalInt(oSkin, "DragonThrall");

    //Invocations
    DeleteLocalInt(oPC, "ChillingFogLock");
    //Endure Exposure wearing off
    array_delete(oPC, "BreathProtected");
    DeleteLocalInt(oPC, "DragonWard");

    //Scry on Familiar
    DeleteLocalInt(oPC, "Scry_Familiar");

    //Template Spell-Like Abilities
    DelayCommand(0.5f, DelayedTemplateSLAs(nGeneration, oPC));

    // future PRCs Go below here
}

void ScrubPCSkin(object oPC, object oSkin)
{
    int nGeneration = PRC_NextGeneration(GetLocalInt(oPC, PRC_ScrubPCSkin_Generation));
    if (DEBUG > 1) DoDebug("ScrubPCSkin Generation: " + IntToString(nGeneration));
    SetLocalInt(oPC, PRC_ScrubPCSkin_Generation, nGeneration);

    int iCode = GetHasFeat(FEAT_SF_CODE,oPC);
    int st;
    if(!(/*GetIsPolyMorphedOrShifted(oPC) || */GetIsObjectValid(GetMaster(oPC))))
    {
    itemproperty ip = GetFirstItemProperty(oSkin);
    while (GetIsItemPropertyValid(ip)) {
        // Insert Logic here to determine if we spare a property
        if (GetItemPropertyType(ip) == ITEM_PROPERTY_BONUS_FEAT)
        {
            // Check for specific Bonus Feats
            // Reference iprp_feats.2da
            st = GetItemPropertySubType(ip);

            // Spare 400 through 570 and 398 -- epic spells & spell effects
            //also spare the new spellbook feats (1000-12000 & 17701-24704
            //also spare the psionic, trunaming, tob, invocation feats (12000-16000)
            // spare template, tob stuff (16300-17700)
            // also spare Pnp spellschool feats and PRC options feat (231-249 & 229)
            // changed by fluffyamoeba so that iprp weapon specialization, dev crit, epic weapon focus, epic weapon spec
            // overwhelming crit and weapon of choice are no longer skipped.
            // 259 - psionic focus
            // 141 - shadowmaster shades, 142-151 bonus domains casting feats
            if ((st < 400 || st > 570)
                && st != 398
                && (st < 1000 || st > 15999)
                //&& (st < 1000 || st > 13999)
                //&& (st < 14501 || st > 15999)
                && (st < 16300 || st > 24704)
                && (st < 223 || st > 226) //draconic feats
                && (st < 229 || st > 249)
                && st != 259
                && (st < 141 || st > 151)
                && ( (st == IP_CONST_FEAT_PRC_POWER_ATTACK_QUICKS_RADIAL || 
                      st == IP_CONST_FEAT_POWER_ATTACK_SINGLE_RADIAL || 
                      st == IP_CONST_FEAT_POWER_ATTACK_FIVES_RADIAL) ? // Remove the PRC Power Attack radials if the character no longer has Power Attack
                     !GetHasFeat(FEAT_POWER_ATTACK, oPC) :
                     TRUE // If the feat is not relevant to this clause, always pass
                    )
                )
                RemoveItemProperty(oSkin, ip);
        }
        else
            RemoveItemProperty(oSkin, ip);

        // Get the next property
        ip = GetNextItemProperty(oSkin);
        }
    }
    if (iCode)
      AddItemProperty(DURATION_TYPE_PERMANENT,PRCItemPropertyBonusFeat(381),oSkin);

    // Schedule restoring the unhealable ability damage
    DelayCommand(0.1f, DelayedReApplyUnhealableAbilityDamage(nGeneration, oPC));

    // Remove all natural weapons too
    // ClearNaturalWeapons(oPC);
    // Done this way to remove prc_inc_natweap and prc_inc_combat from the include
    // Should help with compile speeds and the like
    array_delete(oPC, "ARRAY_NAT_SEC_WEAP_RESREF");
    array_delete(oPC, "ARRAY_NAT_PRI_WEAP_RESREF");
    array_delete(oPC, "ARRAY_NAT_PRI_WEAP_ATTACKS");
}

int BlastInfidelOrFaithHeal(object oCaster, object oTarget, int iEnergyType, int iDisplayFeedback)
{
    //Don't bother doing anything if iEnergyType isn't either positive/negative energy
    if(iEnergyType != DAMAGE_TYPE_POSITIVE && iEnergyType != DAMAGE_TYPE_NEGATIVE)
        return FALSE;

    //If the target is undead and damage type is negative
    //or if the target is living and damage type is positive
    //then we're healing.  Otherwise, we're harming.
    int iTombTainted = GetHasFeat(FEAT_TOMB_TAINTED_SOUL, oTarget) && GetAlignmentGoodEvil(oTarget) != ALIGNMENT_GOOD;
    int iHeal = ( iEnergyType == DAMAGE_TYPE_NEGATIVE && (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || iTombTainted)) ||
                ( iEnergyType == DAMAGE_TYPE_POSITIVE && MyPRCGetRacialType(oTarget) != RACIAL_TYPE_UNDEAD && !iTombTainted);
    int iRetVal = FALSE;
    int iAlignDif = CompareAlignment(oCaster, oTarget);
    string sFeedback = "";

    if(iHeal){
        if((GetHasFeat(FEAT_FAITH_HEALING, oCaster) && iAlignDif < 2)){
            iRetVal = TRUE;
            sFeedback = "Faith Healing";
        }
    }
    else{
        if((GetHasFeat(FEAT_BLAST_INFIDEL, oCaster) && iAlignDif >= 2)){
            iRetVal = TRUE;
            sFeedback = "Blast Infidel";
        }
    }

    if(iDisplayFeedback) FloatingTextStringOnCreature(sFeedback, oCaster);
    return iRetVal;
}

int GetShiftingFeats(object oPC)
{
    int nNumFeats;
    nNumFeats +=   GetHasFeat(FEAT_BEASTHIDE_ELITE, oPC) +
            GetHasFeat(FEAT_DREAMSIGHT_ELITE, oPC) +
            GetHasFeat(FEAT_GOREBRUTE_ELITE, oPC) +
            GetHasFeat(FEAT_LONGSTRIDE_ELITE, oPC) +
            GetHasFeat(FEAT_LONGTOOTH_ELITE, oPC) +
            GetHasFeat(FEAT_RAZORCLAW_ELITE, oPC) +
            GetHasFeat(FEAT_WILDHUNT_ELITE, oPC) +
            GetHasFeat(FEAT_EXTRA_SHIFTER_TRAIT, oPC) +
            GetHasFeat(FEAT_HEALING_FACTOR, oPC) +
            GetHasFeat(FEAT_SHIFTER_AGILITY, oPC) +
            GetHasFeat(FEAT_SHIFTER_DEFENSE, oPC) +
            GetHasFeat(FEAT_GREATER_SHIFTER_DEFENSE, oPC) +
            GetHasFeat(FEAT_SHIFTER_FEROCITY, oPC) +
            GetHasFeat(FEAT_SHIFTER_INSTINCTS, oPC) +
            GetHasFeat(FEAT_SHIFTER_SAVAGERY, oPC);

     return nNumFeats;
}

void FeatUsePerDay(object oPC, int iFeat, int iAbiMod = ABILITY_CHARISMA, int iMod = 0)
{
    if (!GetHasFeat(iFeat,oPC)) return;

    int iAbi = GetAbilityModifier(iAbiMod, oPC);
    iAbi = (iAbi > 0) ? iAbi : 0;

    if (iAbiMod == -1) iAbi = 0;
    iAbi += iMod;

    while (GetHasFeat(iFeat, oPC))
    {
        DecrementRemainingFeatUses(oPC, iFeat);
    }

    while (iAbi)
    {
        IncrementRemainingFeatUses(oPC, iFeat);
        iAbi--;
    }
}

void FeatAlaghar(object oPC)
{
    int iAlagharLevel = GetLevelByClass(CLASS_TYPE_ALAGHAR, oPC);

    if (!iAlagharLevel) return;

    int iClangStrike = iAlagharLevel/3;
    int iClangMight = (iAlagharLevel - 1)/3;
    int iRockburst = (iAlagharLevel + 2)/4;

    FeatUsePerDay(oPC, FEAT_CLANGEDDINS_STRIKE, -1, iClangStrike);
    FeatUsePerDay(oPC, FEAT_CLANGEDDINS_MIGHT, -1, iClangMight);
    FeatUsePerDay(oPC, FEAT_ALAG_ROCKBURST, -1, iRockburst);
}

void FeatContender(object oPC)
{
    int iMod = GetLevelByClass(CLASS_TYPE_MIGHTY_CONTENDER_KORD, oPC) ? GetAbilityModifier(ABILITY_STRENGTH, oPC) : 1;

    FeatUsePerDay(oPC, FEAT_STRENGTH_DOMAIN_POWER, -1, iMod);
}

void FeatDiabolist(object oPC)
{
   int Diabol = GetLevelByClass(CLASS_TYPE_DIABOLIST, oPC);

   if (!Diabol) return;

   int iUse = (Diabol + 3)/3;

   FeatUsePerDay(oPC,FEAT_DIABOL_DIABOLISM_1,-1,iUse);
   FeatUsePerDay(oPC,FEAT_DIABOL_DIABOLISM_2,-1,iUse);
   FeatUsePerDay(oPC,FEAT_DIABOL_DIABOLISM_3,-1,iUse);
}

void FeatNinja (object oPC)
{
    int iNinjaLevel = GetLevelByClass(CLASS_TYPE_NINJA, oPC);

    if (!iNinjaLevel) return;

    int nUsesLeft = iNinjaLevel/2;
    if (nUsesLeft < 1)
        nUsesLeft = 1;

    FeatUsePerDay(oPC, FEAT_KI_POWER, ABILITY_WISDOM, nUsesLeft);
    FeatUsePerDay(oPC, FEAT_GHOST_STEP, ABILITY_WISDOM, nUsesLeft);
    FeatUsePerDay(oPC, FEAT_GHOST_STRIKE, ABILITY_WISDOM, nUsesLeft);
    FeatUsePerDay(oPC, FEAT_GHOST_WALK, ABILITY_WISDOM, nUsesLeft);
    FeatUsePerDay(oPC, FEAT_KI_DODGE, ABILITY_WISDOM, nUsesLeft);

    SetLocalInt(oPC, "prc_ninja_ki", nUsesLeft);
}

void BarbarianRage(object oPC)
{
    if(!GetHasFeat(FEAT_BARBARIAN_RAGE, oPC)) return;

    int nUses = (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) + GetLevelByClass(CLASS_TYPE_PRC_EYE_OF_GRUUMSH, oPC)) / 4 + 1;
    nUses += (GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oPC) + 2) / 5;
    nUses += (GetLevelByClass(CLASS_TYPE_BATTLERAGER, oPC) + 1) / 2;
    nUses += GetLevelByClass(CLASS_TYPE_RUNESCARRED, oPC) ? ((GetLevelByClass(CLASS_TYPE_RUNESCARRED, oPC) / 4) + 1) : 0;

    //if(GetHasFeat(FEAT_EXTRA_RAGE, oPC)) nTotal += 1;

    FeatUsePerDay(oPC, FEAT_BARBARIAN_RAGE, -1, nUses);
    FeatUsePerDay(oPC, FEAT_GREATER_RAGE, -1, nUses);

    if(GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oPC) > 0)
    {
        if(GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oPC) > 9)
            nUses = 3;
        else if(GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oPC) > 4)
            nUses = 2;
        else
            nUses = 1;

        FeatUsePerDay(oPC, FEAT_SPELL_RAGE, -1, nUses);
    }
}

void BardSong(object oPC)
{
    // This is used to set the number of bardic song uses per day, as bardic PrCs can increase it
    // or other classes can grant it on their own
    if(!GetHasFeat(FEAT_BARD_SONGS, oPC)) return;

    int nTotal = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    nTotal += GetLevelByClass(CLASS_TYPE_DIRGESINGER, oPC);
    nTotal += GetLevelByClass(CLASS_TYPE_VIRTUOSO, oPC);
    nTotal += GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD, oPC) / 2;

    if(GetHasFeat(FEAT_EXTRA_MUSIC, oPC)) nTotal += 4;

    FeatUsePerDay(oPC, FEAT_BARD_SONGS, -1, nTotal);
}

void FeatVirtuoso(object oPC)
{
    int iVirtuosoLevel = GetLevelByClass(CLASS_TYPE_VIRTUOSO, oPC);

    if (!iVirtuosoLevel) return;

    int nUses = GetLevelByClass(CLASS_TYPE_BARD, oPC) + iVirtuosoLevel;
    if(GetHasFeat(FEAT_EXTRA_MUSIC, oPC)) nUses += 4;
    SetPersistantLocalInt(oPC, "Virtuoso_Performance_Uses", nUses);
    int nFeat;
    for(nFeat = FEAT_VIRTUOSO_SUSTAINING_SONG; nFeat <= FEAT_VIRTUOSO_PERFORMANCE; nFeat++)
    {
        FeatUsePerDay(oPC, nFeat, -1, nUses);
    }
}

void DivineSongs(object oPC)
{
    int iFoMLevel = GetLevelByClass(CLASS_TYPE_FAVORED_MILIL, oPC);

    if (!iFoMLevel) return;

    int nUses = 3;
    if(GetHasFeat(FEAT_FOM_GREATER_DIVINE_SONG, oPC)) nUses += 2;

    int nFeat;
    for(nFeat = FEAT_FOM_DIVINE_SONG_BLESS; nFeat <= FEAT_FOM_DIVINE_SONG_SPELLRESISTANCE; nFeat++)
    {
        FeatUsePerDay(oPC, nFeat, -1, nUses);
    }
}

void HexCurse(object oPC)
{
    int iHexLevel = GetLevelByClass(CLASS_TYPE_HEXBLADE, oPC);

    if (!iHexLevel) return;

    int nUses = (iHexLevel + 3) / 4; // every 4 levels get 1 more use
    FeatUsePerDay(oPC, FEAT_HEXCURSE, ABILITY_CHARISMA, nUses);
}

void FeatShadowblade(object oPC)
{
    int iShadowLevel = GetLevelByClass(CLASS_TYPE_SHADOWBLADE, oPC);

    if (!iShadowLevel) return;

    FeatUsePerDay(oPC, FEAT_UNSEEN_WEAPON_ACTIVATE, -1, iShadowLevel);
}

void FeatNoble(object oPC)
{
    int iNobleLevel = GetLevelByClass(CLASS_TYPE_NOBLE, oPC);

    if (!iNobleLevel) return;

    int nBonus = 0;
    if (iNobleLevel >= 17) nBonus = 5;
    else if (iNobleLevel >= 13) nBonus = 4;
    else if (iNobleLevel >= 9) nBonus = 3;
    else if (iNobleLevel >= 5) nBonus = 2;
    else if (iNobleLevel >= 2) nBonus = 1;

    FeatUsePerDay(oPC, FEAT_NOBLE_CONFIDENCE, -1, nBonus);

    nBonus = (iNobleLevel - 11) / 3 + 1;

    FeatUsePerDay(oPC, FEAT_NOBLE_GREATNESS, -1, nBonus);
}

void DarkKnowledge(object oPC)
{
    int iArchivistLevel = GetLevelByClass(CLASS_TYPE_ARCHIVIST, oPC);

    if(!iArchivistLevel) return;

    int nUses = (iArchivistLevel / 3) + 3;
    FeatUsePerDay(oPC, FEAT_DK_TACTICS,       -1, nUses);
    FeatUsePerDay(oPC, FEAT_DK_PUISSANCE,     -1, nUses);
    FeatUsePerDay(oPC, FEAT_DK_FOE,           -1, nUses);
    FeatUsePerDay(oPC, FEAT_DK_DREADSECRET,   -1, nUses);
    FeatUsePerDay(oPC, FEAT_DK_FOREKNOWLEDGE, -1, nUses);
}

void VestigeMeta(object oPC)
{
    /*int nUses;
    int nLevel = GetLevelByClass(CLASS_TYPE_ANIMA_MAGE, oPC);
    nUses = (nLevel >= 9) ? 3 : (nLevel >= 7) ? 2 : 1;
    FeatUsePerDay(oPC, FEAT_VESTIGE_METAMAGIC, -1, nUses);*/
}

void FeatSunDomain(object oPC)
{
    int nAbi, nUses;
    if(!GetHasTurnUndead(oPC) && GetLevelByClass(CLASS_TYPE_MYSTIC, oPC))
    {
        nAbi = ABILITY_CHARISMA;
        nUses = GetHasFeat(FEAT_EXTRA_TURNING, oPC) ? 7 : 3;
    }
    else
    {
        nAbi = -1;
        nUses = 1;
    }
    FeatUsePerDay(oPC, FEAT_SUN_DOMAIN_POWER, nAbi, nUses);
}

void FeatImbueArrow(object oPC)
{
    if(GetPRCSwitch(PRC_USE_NEW_IMBUE_ARROW))
        FeatUsePerDay(oPC, FEAT_PRESTIGE_IMBUE_ARROW, -1, 0);
}

void FeatRacial(object oPC)
{
    //Shifter bonus shifting uses
    if(GetRacialType(oPC) == RACIAL_TYPE_SHIFTER)
    {
        int nShiftFeats = GetShiftingFeats(oPC);
        int nBonusShiftUses = (nShiftFeats / 2) + 1;
        FeatUsePerDay(oPC, FEAT_SHIFTER_SHIFTING, -1, nBonusShiftUses);
    }

    //Add daily Uses of Fiendish Resilience for epic warlock
    if(GetHasFeat(FEAT_EPIC_FIENDISH_RESILIENCE_I))
    {
        int nFeatAmt = 0;
        int bDone = FALSE;
        while(!bDone)
        {
            if(nFeatAmt >= 9)
                bDone = TRUE;
            else if(GetHasFeat(FEAT_EPIC_FIENDISH_RESILIENCE_II + nFeatAmt))
            {
                IncrementRemainingFeatUses(oPC, FEAT_FIENDISH_RESILIENCE);
                nFeatAmt++;
            }
            else
                bDone = TRUE;
        }
    }

    if(GetRacialType(oPC) == RACIAL_TYPE_FORESTLORD_ELF)
    {
        int nUses = GetHitDice(oPC) / 5 + 1;
        FeatUsePerDay(oPC, FEAT_FORESTLORD_TREEWALK, -1, nUses);
    }
}

void FeatSpecialUsePerDay(object oPC)
{
    FeatUsePerDay(oPC,FEAT_FIST_OF_IRON, ABILITY_WISDOM, 3);
    FeatUsePerDay(oPC,FEAT_SMITE_UNDEAD, ABILITY_CHARISMA, 3);
    FeatDiabolist(oPC);
    FeatAlaghar(oPC);
    FeatUsePerDay(oPC, FEAT_SA_SHIELDSHADOW, -1, GetPrCAdjustedCasterLevelByType(TYPE_ARCANE,oPC));
    FeatUsePerDay(oPC, FEAT_HEALING_KICKER_1, ABILITY_WISDOM, GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, oPC));
    FeatUsePerDay(oPC, FEAT_HEALING_KICKER_2, ABILITY_WISDOM, GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, oPC));
    FeatUsePerDay(oPC, FEAT_HEALING_KICKER_3, ABILITY_WISDOM, GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, oPC));
    FeatNinja(oPC);
    FeatNoble(oPC);
    FeatContender(oPC);
    FeatUsePerDay(oPC, FEAT_LASHER_STUNNING_SNAP, -1, GetLevelByClass(CLASS_TYPE_LASHER, oPC));
    FeatUsePerDay(oPC, FEAT_AD_FALSE_KEENNESS, -1, GetLevelByClass(CLASS_TYPE_ARCANE_DUELIST, oPC));
    FeatUsePerDay(oPC, FEAT_AD_BLUR, -1, GetLevelByClass(CLASS_TYPE_ARCANE_DUELIST, oPC));
    FeatUsePerDay(oPC, FEAT_LIPS_RAPTUR);
    FeatUsePerDay(oPC, FEAT_MOS_UNDEAD_1, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_MOS_UNDEAD_2, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_MOS_UNDEAD_3, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_MOS_UNDEAD_4, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_DOMAIN_POWER_BLIGHTBRINGER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_AIR_DOMAIN_POWER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_EARTH_DOMAIN_POWER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_FIRE_DOMAIN_POWER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_WATER_DOMAIN_POWER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_DOMAIN_POWER_SLIME, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_DOMAIN_POWER_SPIDER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_DOMAIN_POWER_SCALEYKIND, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_PLANT_DOMAIN_POWER, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_WWOC_WIDEN_SPELL, ABILITY_CHARISMA, GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, oPC));
    FeatUsePerDay(oPC, FEAT_COC_WRATH, ABILITY_CHARISMA, 3);
    FeatUsePerDay(oPC, FEAT_FIST_DAL_QUOR_STUNNING_STRIKE, -1, GetLevelByClass(CLASS_TYPE_FIST_DAL_QUOR, oPC));
    HexCurse(oPC);
    FeatRacial(oPC);
    FeatShadowblade(oPC);

    int nDread = GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oPC);
    if (nDread >= 17)
        FeatUsePerDay(oPC, FEAT_DN_ENERVATING_TOUCH, -1, nDread);
    else
        FeatUsePerDay(oPC, FEAT_DN_ENERVATING_TOUCH, -1, nDread/2);

    if(GetPersistantLocalInt(oPC, "PRC_SLA_Uses_1"))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_1, -1, GetPersistantLocalInt(oPC, "PRC_SLA_Uses_1"));
    else if(GetHasFeat(FEAT_SPELL_LIKE_ABILITY_1, oPC))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_1, -1, 1);

    if(GetPersistantLocalInt(oPC, "PRC_SLA_Uses_2"))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_2, -1, GetPersistantLocalInt(oPC, "PRC_SLA_Uses_2"));
    else if(GetHasFeat(FEAT_SPELL_LIKE_ABILITY_2, oPC))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_2, -1, 1);

    if(GetPersistantLocalInt(oPC, "PRC_SLA_Uses_3"))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_3, -1, GetPersistantLocalInt(oPC, "PRC_SLA_Uses_3"));
    else if(GetHasFeat(FEAT_SPELL_LIKE_ABILITY_3, oPC))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_3, -1, 1);

    if(GetPersistantLocalInt(oPC, "PRC_SLA_Uses_4"))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_4, -1, GetPersistantLocalInt(oPC, "PRC_SLA_Uses_4"));
    else if(GetHasFeat(FEAT_SPELL_LIKE_ABILITY_4, oPC))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_4, -1, 1);

    if(GetPersistantLocalInt(oPC, "PRC_SLA_Uses_5"))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_5, -1, GetPersistantLocalInt(oPC, "PRC_SLA_Uses_5"));
    else if(GetHasFeat(FEAT_SPELL_LIKE_ABILITY_5, oPC))
        FeatUsePerDay(oPC, FEAT_SPELL_LIKE_ABILITY_5, -1, 1);

    BardSong(oPC);
    BarbarianRage(oPC);
    FeatVirtuoso(oPC);
    ResetExtraStunfistUses(oPC);
    VestigeMeta(oPC);
    DivineSongs(oPC);
    DarkKnowledge(oPC);
    FeatSunDomain(oPC);
    FeatImbueArrow(oPC);
}

//Including DelayedApplyEffectToObject here because it is often used in conjunction with EvalPRCFeats and I don't know a better place to put it
void DelayedApplyEffectToObject(int nExpectedGeneration, int nCurrentGeneration, int nDuration, effect eEffect, object oTarget, float fDuration)
{
    if (nExpectedGeneration != nCurrentGeneration)
    {
        //Generation has changed, so don't apply the effect
        return;
    }
    ApplyEffectToObject(nDuration, eEffect, oTarget, fDuration);
}

//Including DelayedApplyEffectToObject here because it is often used in conjunction with EvalPRCFeats and I don't know a better place to put it
void DelayApplyEffectToObject(float fDelay, string sGenerationName, int nDuration, effect eEffect, object oTarget, float fDuration = 0.0f)
{
    /*
    There are a couple of problems that can arise in code that removes and reapplies effects; 
    this function helps deal with those problems. One example of a typical place where these problems 
    frequently arise is in the class scripts called by the EvalPRCFeats function.

    The first problem is that when code removes and immediately reapplies a series of effects,
    some of those effects may not actually be reapplied. This is because the RemoveEffect() function 
    doesn't actually remove an effect, it marks it to be removed later--when the currently running 
    script finishes. If any of the effects we reapply matches one of the effects marked to be
    removed, that reapplied effect will be removed when the currently running script finishes
    and so will be unexpectedly missing. To illustrate:
        1) We start with effect A and B.
        2) The application function is called; it removes all effects and reapplies effects B and C.
        3) The actual removal happens when the script ends: effect A and B are removed.
        End result: we have only effect C instead of the expected B and C.
    The solution to this is to reapply the effects later using DelayCommand().
    
    This introduces a new problem. If the function that removes and reapplies the effects is called
    multiple times quickly, it can queue up a series of delayed applications. This causes two problems:
    if the data on which the effects are calculated changes, the earlier delayed applications can
    apply effects that should no longer be used, but they are anyway because the delayed code doesn't
    know this. To illustrate:
        1) The application function is called; it removes all effects, schedules delayed application of effect A.
        2) The application function is called again; it removes all effects, schedules delayed application of effect B.
        3) Delayed application of effect A occurs.
        4) Delayed application of effect B occurs.
        End result: we have both effect A and B instead of the expected result, B alone.
    Another problem is that we can end up with multiple copies of the same effect.
    If this happens enough, it can cause "Effect List overflow" errors. Also, if the effect stacks
    with itself, this gives a greater bonus or penalty than it should. To illustrate:
        1) The application function is called; it removes all effects, schedules delayed application of effect C.
        2) The application function is called; it removes all effects, schedules delayed application of effect C.
        3) Delayed application of effect C occurs.
        4) Delayed application of effect C occurs.
        End result: we have effect C twice instead of just once.
    The solution is to both these problems is for the application function to increment an integer each time it
    is called and to pass this to the delayed application function. The delayed application actually happens only
    if the generation when it runs is the same as the generation when it was scheduled. To illustrate:
        1) We start with effect A and B applied.
        2) The application function is called: it increments generation to 2, schedules delayed application of effect B and C.
        3) The application function is called: it increments generation to 3, schedules delayed application of effect C.
        4) The generation 2 delayed application function executes: it sees that the current generation is 3 and simply exits, doing nothing.
        5) The generation 3 delayed application function executes: it sees that the current generation is 3, so it applies effect C.
        End result: we have one copy of effect C, which is what we wanted.
    */

    if (fDelay < 0.0f || GetStringLength(sGenerationName) == 0)
    {
        ApplyEffectToObject(nDuration, eEffect, oTarget, fDuration);
    }
    else
    {
        int nExpectedGeneration = GetLocalInt(oTarget, sGenerationName); //This gets the generation now
        DelayCommand(
            fDelay, 
            DelayedApplyEffectToObject(
                nExpectedGeneration, 
                GetLocalInt(oTarget, sGenerationName), //This is delayed by the DelayCommand, so it gets the generation when DelayedApplyEffectToObject is actually executed
                nDuration, 
                eEffect,
                oTarget,
                fDuration
            )
        );
    }
}

//Including DelayedAddItemProperty here to keep it with DelayedApplyEffectToObject, though more properly it should probably be in inc_item_props.nss
void DelayedAddItemProperty(int nExpectedGeneration, int nCurrentGeneration, int nDurationType, itemproperty ipProperty, object oItem, float fDuration)
{
    if (nExpectedGeneration != nCurrentGeneration)
    {
        //Generation has changed, so don't apply the effect
        return;
    }
    AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
}

//Including DelayAddItemProperty here to keep it with DelayApplyEffectToObject, though more properly it should probably be in inc_item_props.nss
void DelayAddItemProperty(float fDelay, object oGenerationHolder, string sGenerationName, int nDurationType, itemproperty ipProperty, object oItem, float fDuration = 0.0f)
{
    /*
    There are a couple of problems that can arise in code that removes and reapplies item properties;
    this function helps deal with those problems. One example of a typical place where these problems 
    frequently arise is in the class scripts called by the EvalPRCFeats function.

    The first problem is that when code removes and immediately reapplies a series of item properties,
    some of those properties may not actually be reapplied. This is because the RemoveItemProperty() function 
    doesn't actually remove a property, it marks it to be removed later--when the currently running 
    script finishes. If any of the properties we reapply matches one of the properties marked to be
    removed, that reapplied property will be removed when the currently running script finishes
    and so will be unexpectedly missing. To illustrate:
        1) We start with properties A and B.
        2) The application function is called; it removes all properties and reapplies properties B and C.
        3) The actual removal happens when the script ends: property A and B are removed.
        End result: we have only property C instead of the expected B and C.
    The solution to this is to reapply the properties later using DelayCommand().
    
    This introduces a new problem. If the function that removes and reapplies the properties is called
    multiple times quickly, it can queue up a series of delayed applications. This causes two problems:
    if the data on which the properties are calculated changes, the earlier delayed applications can
    apply properties that should no longer be used, but they are anyway because the delayed code doesn't
    know this. To illustrate:
        1) The application function is called; it removes all properties, schedules delayed application of property A.
        2) The application function is called again; it removes all properties, schedules delayed application of property B.
        3) Delayed application of property A occurs.
        4) Delayed application of property B occurs.
        End result: we have both property A and B instead of the expected result, B alone.
    Another problem is that we can end up with multiple copies of the same property.
    If this happens enough, it can cause "Effect List overflow" errors. Also, if the property stacks
    with itself, this gives a greater bonus or penalty than it should. To illustrate:
        1) The application function is called; it removes all properties, schedules delayed application of property C.
        2) The application function is called; it removes all properties, schedules delayed application of property C.
        3) Delayed application of property C occurs.
        4) Delayed application of property C occurs.
        End result: we have property C twice instead of just once.
    The solution is to both these problems is for the application function to increment an integer each time it
    is called and to pass this to the delayed application function. The delayed application actually happens only
    if the generation when it runs is the same as the generation when it was scheduled. To illustrate:
        1) We start with property A and B applied.
        2) The application function is called: it increments generation to 2, schedules delayed application of property B and C.
        3) The application function is called: it increments generation to 3, schedules delayed application of property C.
        4) The generation 2 delayed application function executes: it sees that the current generation is 3 and simply exits, doing nothing.
        5) The generation 3 delayed application function executes: it sees that the current generation is 3, so it applies property C.
        End result: we have one copy of property C, which is what we wanted.
    */
    
    if (fDelay < 0.0f || GetStringLength(sGenerationName) == 0)
    {
        AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
    }
    else
    {
        int nExpectedGeneration = GetLocalInt(oGenerationHolder, sGenerationName); //This gets the generation now
        DelayCommand(
            fDelay, 
            DelayedAddItemProperty(
                nExpectedGeneration, 
                GetLocalInt(oGenerationHolder, sGenerationName), //This is delayed by the DelayCommand, so it gets the generation when DelayedAddItemProperty is actually executed
                nDurationType, 
                ipProperty,
                oItem,
                fDuration
            )
        );
    }
}

