/*
Smite Evil: Once per day, a paladin of 2nd level or higher may
attempt to smite evil with one normal melee attack. She adds her
Charisma modifier (if positive) to her attack roll and deals 1 extra
point of damage per level. For example, a 13th-level paladin armed
with a longsword would deal 1d8+13 points of damage, plus any
additional bonuses for high Strength or magical effects that
normally apply. If the paladin accidentally smites a creature that is
not evil, the smite has no effect but it is still used up for that day.
*/
/*
Good
    Anti-paldin
    Blackguard
    Fiendish Template
    Half-fiend Template
Evil
    Paladin
    Fist of Raziel
    Celestial Template
    Half-celestial Template
Undead
    Soldier of Light
Infidel
    Champion of Bane
    Champion of Torm
CW Samurai
    Kiai
*/

const int SMITE_TYPE_GOOD_ANTIPALADIN               = 11;
const int SMITE_TYPE_GOOD_BLACKGUARD                = 12; //not used, biowares is adequate
const int SMITE_TYPE_GOOD_TEMPLATE_FIENDISH         = 13;
const int SMITE_TYPE_GOOD_TEMPLATE_HALF_FIEND       = 14;

const int SMITE_TYPE_EVIL_PALADIN                   = 21; //not used, biowares is adequate
const int SMITE_TYPE_EVIL_FIST_OF_RAZIEL            = 22;
const int SMITE_TYPE_EVIL_TEMPLATE_CELESTIAL        = 23;
const int SMITE_TYPE_EVIL_TEMPLATE_HALF_CELESTIAL   = 24;

const int SMITE_TYPE_UNDEAD                         = 31;

const int SMITE_TYPE_INFIDEL                        = 41;

const int SMITE_TYPE_KIAI                           = 51;
const int SMITE_TYPE_CRUSADER                       = 52;

//this calculates damage and stuff from class and type
//takes epic smiting feats etc into account
//takes FoR special smiteing abilities into account too
//It DOES NOT decrease smites remaining
void DoSmite(object oPC, object oTarget, int nType);

#include "prc_inc_combat"
#include "prc_inc_racial"
#include "prc_class_const"

void DoSmite(object oPC, object oTarget, int nType)
{
    effect eSmite; //effect OnHit
    int nDamage;
    int nDamageType;
    int nAttack;
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sHit;
    string sMiss;
    string sFailedTarget;
    string sFailedSmiter;
    int nTargetInvalid = !GetIsObjectValid(oTarget);
    int nSmiterInvalid = !GetIsObjectValid(oPC);
    if(nType == SMITE_TYPE_EVIL_FIST_OF_RAZIEL
    || nType == SMITE_TYPE_EVIL_PALADIN
    || nType == SMITE_TYPE_EVIL_TEMPLATE_CELESTIAL
    || nType == SMITE_TYPE_EVIL_TEMPLATE_HALF_CELESTIAL)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);

        if(nType == SMITE_TYPE_EVIL_PALADIN)
        {
            nDamage = GetLevelByClass(CLASS_TYPE_PALADIN, oPC)
                    + GetLevelByClass(CLASS_TYPE_FISTRAZIEL, oPC)
                    + GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC);
            nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
            if(nAttack < 1)
                nAttack = 1;
        }
        else if(nType == SMITE_TYPE_EVIL_FIST_OF_RAZIEL)
        {
            nDamage = GetLevelByClass(CLASS_TYPE_FISTRAZIEL, oPC)
                    + GetLevelByClass(CLASS_TYPE_PALADIN, oPC)
                    + GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC);
            nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
            if(nAttack < 1)
                nAttack = 1;
        }
        else if(nType == SMITE_TYPE_EVIL_TEMPLATE_CELESTIAL)
        {
            nDamage = GetHitDice(oPC);
            if(nDamage > 20)
                nDamage = 20;
        }
        else if(nType == SMITE_TYPE_EVIL_TEMPLATE_HALF_CELESTIAL)
        {
            nDamage = GetHitDice(oPC);
            if(nDamage > 20)
                nDamage = 20;
        }

        nDamageType = DAMAGE_TYPE_DIVINE;
        sFailedTarget = "Smite Failed: target is not Evil";
        sFailedSmiter = "Smite Failed: you are not Good";
        sHit =  "Smite Evil Hit";
        sMiss = "Smite Evil Missed";
        if(GetAlignmentGoodEvil(oTarget)        != ALIGNMENT_EVIL)
            nTargetInvalid = TRUE;
        if(GetAlignmentGoodEvil(oPC)            != ALIGNMENT_GOOD)
            nSmiterInvalid = TRUE;

        //Fist of Raziel special stuff
        if(nType == SMITE_TYPE_EVIL_FIST_OF_RAZIEL)
        {
            //good aligned weapon (+1 enhancement to break DR)
            if(GetHasFeat(FEAT_SMITE_GOOD_ALIGN, oPC))
                AddItemProperty(DURATION_TYPE_TEMPORARY,
                    ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, 1),
                    oWeapon, 0.1);

            //criticals always hit
            if(GetHasFeat(FEAT_SMITE_CONFIRMING, oPC))
                SetLocalInt(oPC, "FistOfRazielSpecialSmiteCritical", TRUE);

            //2d8 vs outsiders or undead
            if(GetHasFeat(FEAT_SMITE_FIEND, oPC)
                && (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER
                    || MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD))
                AddItemProperty(DURATION_TYPE_TEMPORARY,
                    ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,
                        DAMAGE_TYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d8),
                    oWeapon, 0.1);

            //these are either or, not both
            else if(GetHasFeat(FEAT_SMITE_HOLY, oPC))
                AddItemProperty(DURATION_TYPE_TEMPORARY,
                    ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,
                        DAMAGE_TYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6),
                    oWeapon, 0.1);

            //chain bolt stuff
            if(GetHasFeat(FEAT_SMITE_CHAIN, oPC))
            {
                int nTargetCount = 5;
                int i = 1;
                object oSecondTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
                //GetFirstObjectInShape(SHAPE_SPHERE,
                //    RADIUS_SIZE_LARGE, GetLocation(oPC), TRUE, OBJECT_TYPE_CREATURE);
                while(GetIsObjectValid(oSecondTarget)
                    && nTargetCount > 0
                    && GetDistanceBetween(oPC, oSecondTarget) < FeetToMeters(30.0))
                {
                    if(GetAlignmentGoodEvil(oSecondTarget) == ALIGNMENT_EVIL
                        && oTarget != oSecondTarget)
                    {
                        int nDamage;
                        if(MyPRCGetRacialType(oSecondTarget) == RACIAL_TYPE_OUTSIDER
                            || MyPRCGetRacialType(oSecondTarget) == RACIAL_TYPE_UNDEAD)
                            nDamage = d8(2);
                        else
                            nDamage = d6(2);
                        nDamage = PRCGetReflexAdjustedDamage(nDamage, oSecondTarget,
                            15+(GetAbilityModifier(ABILITY_CHARISMA, oPC)/2),
                                SAVING_THROW_TYPE_NONE, oPC);
                        effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                        effect eBeam = EffectBeam(VFX_BEAM_HOLY, oPC, BODY_NODE_HAND);
                        effect eVFX = EffectVisualEffect(VFX_COM_HIT_DIVINE);
                        SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSecondTarget);
                        SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oSecondTarget, 0.5);
                        SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oSecondTarget);
                        nTargetCount --;
                    }
                    i++;
                    oSecondTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
                }
            }
        }
    }

    else if(nType == SMITE_TYPE_GOOD_ANTIPALADIN
          || nType == SMITE_TYPE_GOOD_BLACKGUARD)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);
        if(nType == SMITE_TYPE_GOOD_BLACKGUARD)
        {
            nDamage = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)
                    + GetLevelByClass(CLASS_TYPE_ANTI_PALADIN, oPC)
                    + GetLevelByClass(CLASS_TYPE_CHAMPION_BANE, oPC);
            nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
            if(nAttack < 1)
                nAttack = 1;
        }
        else if(nType == SMITE_TYPE_GOOD_ANTIPALADIN)
        {
            nDamage = GetLevelByClass(CLASS_TYPE_ANTI_PALADIN, oPC)
                    + GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)
                    + GetLevelByClass(CLASS_TYPE_CHAMPION_BANE, oPC);
            nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
            if(nAttack < 1)
                nAttack = 1;
        }
        else if(nType == SMITE_TYPE_GOOD_TEMPLATE_FIENDISH)
        {
            nDamage = GetHitDice(oPC);
            if(nDamage > 20)
                nDamage = 20;
        }
        else if(nType == SMITE_TYPE_GOOD_TEMPLATE_HALF_FIEND)
        {
            nDamage = GetHitDice(oPC);
            if(nDamage > 20)
                nDamage = 20;
        }
        nDamageType = DAMAGE_TYPE_DIVINE;
        sFailedTarget = "Smite Failed: target is not Good";
        sFailedSmiter = "Smite Failed: you are not Evil";
        sHit =  "Smite Good Hit";
        sMiss = "Smite Good Missed";
        if(GetAlignmentGoodEvil(oTarget)        != ALIGNMENT_GOOD)
            nTargetInvalid = TRUE;
        if(GetAlignmentGoodEvil(OBJECT_SELF)    != ALIGNMENT_EVIL)
            nSmiterInvalid = TRUE;
    }

    else if(nType == SMITE_TYPE_UNDEAD)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);
        nAttack = GetAbilityModifier(ABILITY_WISDOM, oPC);
        nDamage = GetLevelByClass(CLASS_TYPE_SOLDIER_OF_LIGHT, oPC);
        nDamageType = DAMAGE_TYPE_POSITIVE;
        sFailedTarget = "Smite Failed: target is not Undead";
        sFailedSmiter = "Smite Failed: you are not Good";
        sHit =  "Smite Undead Hit";
        sMiss = "Smite Undead Missed";
        if(MyPRCGetRacialType(oTarget)          != RACIAL_TYPE_UNDEAD)
            nTargetInvalid = TRUE;
        if(GetAlignmentGoodEvil(OBJECT_SELF)    != ALIGNMENT_GOOD)
            nSmiterInvalid = TRUE;
    }

    else if(nType == SMITE_TYPE_INFIDEL)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);
        nDamage = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC) //CoT
                + GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
        nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
        string sDeity = "Torm";
        //if bane levels higher, use that
        if(GetLevelByClass(CLASS_TYPE_CHAMPION_BANE, oPC) > nDamage)
        {
            nDamage = GetLevelByClass(CLASS_TYPE_CHAMPION_BANE, oPC)
                    + GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
            sDeity = "Bane";
        }
        nDamageType = DAMAGE_TYPE_POSITIVE;
        if(nAttack < 1)
            nAttack = 1;
        sFailedTarget = "Smite Failed: target has the same deity";
        sFailedSmiter = "Smite Failed: you do not follow your deity";
        sHit =  "Smite Infidel Hit";
        sMiss = "Smite Infidel Missed";
        if(GetStringLowerCase(GetDeity(oTarget))== GetStringLowerCase(GetDeity(oPC)))
            nTargetInvalid = TRUE;
        if(GetStringLowerCase(GetDeity(oPC))    != GetStringLowerCase(sDeity))
            nSmiterInvalid = TRUE;
    }

    else if(nType == SMITE_TYPE_KIAI)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);
        nDamage = GetAbilityModifier(ABILITY_CHARISMA, oPC);
        if(nDamage < 1)
            nDamage = 1;
        nAttack = GetAbilityModifier(ABILITY_CHARISMA, oPC);
        if(nAttack < 1)
            nAttack = 1;
        nDamageType = DAMAGE_TYPE_DIVINE;
        sFailedTarget = "Target cannot be invalid";
        sFailedSmiter = "Smite Failed: you are not Lawful";
        sHit =  "Kiai Smite Hit";
        sMiss = "Kiai Smite Missed";
        if(GetAlignmentLawChaos(OBJECT_SELF)    != ALIGNMENT_LAWFUL)
            nSmiterInvalid = TRUE;
    }

    else if(nType == SMITE_TYPE_CRUSADER)
    {
        eSmite = EffectVisualEffect(VFX_COM_HIT_DIVINE);
        nDamage = GetAbilityModifier(ABILITY_CHARISMA, oPC);
        if(nDamage < 1)
            nDamage = 0; // Can't go negative
        nAttack = GetLevelByClass(CLASS_TYPE_CRUSADER, oPC);
        nDamageType = DAMAGE_TYPE_MAGICAL;
        sFailedTarget = "Target cannot be invalid";
        sFailedSmiter = "Smite Failed: Report Error";
        sHit =  "Crusader Smite Hit";
        sMiss = "Crusader Smite Missed";
    }

    //check target is valid
    //and show message if not
    if(nTargetInvalid)
        FloatingTextStringOnCreature(sFailedTarget, oPC);

    //check smiter is valid
    //and show message if not
    else if(nSmiterInvalid)
        FloatingTextStringOnCreature(sFailedSmiter, oPC);

    //check for ranged weapon
    //ranged smite was never finished
    //if it was, here would be the place to put it!
    else if (GetWeaponRanged(oWeapon) && !GetHasFeat(FEAT_RANGED_SMITE, oPC))
        FloatingTextStringOnCreature("Smite Failed: cannot use ranged weapon", oPC);

    //passed checks, do the actual smite
    else
    {
        //add epic smiting damage
        int iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_1) ? 2:1;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_2) ? 3:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_3) ? 4:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_4) ? 5:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_5) ? 6:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_6) ? 7:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_7) ? 8:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_8) ? 9:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_9) ? 10:iEpicSmite;
            iEpicSmite = GetHasFeat(FEAT_EPIC_GREAT_SMITING_10)? 11:iEpicSmite;
        nDamage *= iEpicSmite;

        //whew, now we can do the actual smite through the combat engine
        PerformAttackRound(oTarget, oPC, eSmite, 0.0, nAttack, nDamage, nDamageType, FALSE, sHit, sMiss);
    }
}