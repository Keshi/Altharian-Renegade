//::///////////////////////////////////////////////
//:: Bard Song
//:: NW_S2_BardSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spells applies bonuses to all of the
    bard's allies within 30ft for a set duration of
    10 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 25, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller Oct 1, 2003
/*
bugfix by Kovi 2002.07.30
- loosing temporary hp resulted in loosing the other bonuses
*/
// Modified by Farmer for Altharian Adventures. Primary raised Damage, AC, Bonus HP.
// Made Modifications until line 327, did not modify any further due to Saint Quests.
// This is 1st draft.
#include "x0_i0_spells"
#include "wk_tools"

void main()
{
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
    string sTag = GetTag(OBJECT_SELF);

    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int nRanks = GetSkillRank(SKILL_PERFORM,OBJECT_SELF,FALSE);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    object oPC = OBJECT_SELF;
    int nDuration = 10; //+ nChr;
    int nBard = GetHarmonic(OBJECT_SELF);
    int nEffLevel = GetEffectiveLevel(OBJECT_SELF);
    if (nBard > 2 && nEffLevel > 40)
      {
        nLevel = nLevel * nEffLevel / 40;
      }
    if (nBard == 1 || nBard >= 3)
      {
        nDuration = nLevel;
        if (nDuration > 25) nDuration = 25;
      }
    effect eAttack;
    effect eDamage;
    effect eWill;
    effect eFort;
    effect eReflex;
    effect eHP;
    effect eAC;
    effect eSkill;

    int nAttack;
    int nDamage;
    int nWill;
    int nFort;
    int nReflex;
    int nHP;
    int nAC;
    int nSkill;
    //Check to see if the caster has Lasting Impression and increase duration.
    // lingering song
    if(GetHasFeat(424)) // lingering song
    {
        nDuration += (5 + nBard);
    }

    if(GetHasFeat(870))
    {
        nDuration *= (3);
    }

    //SpeakString("Level: " + IntToString(nLevel) + " Ranks: " + IntToString(nRanks));
    //Was in order decending 2,3,3,3,3,49,7,19
    if(nPerform >= 85 && nLevel >= 41)
    {
        nAttack = nLevel/7 + nBard + 1;
        nDamage = nPerform + nLevel;
        nWill = (nLevel/10) + nBard + 1;
        nFort = (nLevel/10) + nBard + 1;
        nReflex = (nLevel/10) + nBard + 2;
        nHP = nPerform * (3 + nBard);
        nAC = (nPerform + nLevel)/20 + 6 + nBard;
        nSkill = nLevel / 2;
        if (nSkill > 30) nSkill = 30;
    }
    else if(nPerform >= nLevel && nLevel >= 25 && nBard >= 1)
    {
        nAttack = nLevel/8 + 1;
        nDamage = nPerform;
        nWill = (nLevel/12) + 1;
        nFort = (nLevel/12) + 1;
        nReflex = (nLevel/12) + 2;
        nHP = nPerform * 3;
        nAC = nPerform/15 + 6;
        nSkill = nLevel / 3 * 2;
        if (nSkill > 25) nSkill = 25;
    }
    else if(nPerform >= nLevel && nLevel >= 21)
    {
        nAttack = nLevel/10 + 1;
        nDamage = nPerform;
        nWill = (nLevel/15) + 1;
        nFort = (nLevel/15) + 1;
        nReflex = (nLevel/15) + 2;
        nHP = nPerform * 2;
        nAC = nLevel/15 + 6;
        nSkill = nLevel/2;
        if (nSkill > 25) nSkill = 25;
    }
    else if (nLevel >= 1)
    {
   // Was 2,3,3,2,2,46,6,18
        nAttack = nLevel/12 + 1;
        nDamage = nLevel;
        nWill = (nLevel/20) + 1;
        nFort = (nLevel/20) + 1;
        nReflex = (nLevel/20) + 2;
        nHP = nLevel * 2;
        nAC = nLevel/4;
        nSkill = nLevel/2;
    }

    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

    eAttack = EffectAttackIncrease(nAttack);
    SendMessageToPC(oPC,"Attack Bonus " + IntToString(nAttack));
    eDamage = EffectDamageIncrease(30, DAMAGE_TYPE_MAGICAL);
    SendMessageToPC(oPC,"Damage Bonus " + IntToString(nDamage));
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nWill > 0)
    {
        eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWill);
        eLink = EffectLinkEffects(eLink, eWill);
        SendMessageToPC(oPC,"Will Bonus " + IntToString(nWill));
    }
    if(nFort > 0)
    {
        eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nFort);
        eLink = EffectLinkEffects(eLink, eFort);
        SendMessageToPC(oPC,"Fort Bonus " + IntToString(nFort));
    }
    if(nReflex > 0)
    {
        eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
        eLink = EffectLinkEffects(eLink, eReflex);
        SendMessageToPC(oPC,"Reflex Bonus " + IntToString(nReflex));
    }
    if(nHP > 0)
    {
        SendMessageToPC(oPC,"HP Bonus " + IntToString(nHP));
        eHP = EffectTemporaryHitpoints(nHP);
        eLink = EffectLinkEffects(eLink, eHP);
    }
    if(nAC > 0)
    {
        eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
        SendMessageToPC(oPC,"AC Bonus " + IntToString(nAC));
    }
    if(nSkill > 0)
    {
        eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
        SendMessageToPC(oPC,"Skills Bonus " + IntToString(nSkill));
    }
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

    eHP = ExtraordinaryEffect(eHP);
    eLink = ExtraordinaryEffect(eLink);

    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
        {
             // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
             if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
             {
                if(oTarget == OBJECT_SELF)
                {
                    effect eLinkBard = EffectLinkEffects(eLink, eVis);
                    eLinkBard = ExtraordinaryEffect(eLinkBard);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
                else if(GetIsFriend(oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

