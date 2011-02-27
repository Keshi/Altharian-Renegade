//::///////////////////////////////////////////////
//:: Sunbeam
//:: s_Sunbeam.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: All creatures in the beam are struck blind and suffer 4d6 points of damage. (A successful
//:: Reflex save negates the blindness and reduces the damage by half.) Creatures to whom sunlight
//:: is harmful or unnatural suffer double damage.
//::
//:: Undead creatures caught within the ray are dealt 1d6 points of damage per caster level
//:: (maximum 20d6), or half damage if a Reflex save is successful. In addition, the ray results in
//:: the total destruction of undead creatures specifically affected by sunlight if they fail their saves.
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: Feb 22, 2001
//:://////////////////////////////////////////////
//:: Last Modified By: Keith Soleski, On: March 21, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

//:: modified by mr_bumpkin  Dec 4, 2003
#include "prc_inc_spells"
#include "prc_add_spell_dc"
 #include "wk_tools"



void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = PRCGetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eStrike = EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eDam;
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBlind, eDur);
    int nCasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nOrgDam;
    int nMax;
    float fDelay;
    int nBlindLength = 3;
//altharian mods
    int nDice = 6;
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nVesper = GetVesper(OBJECT_SELF);
    int nDruid = GetWhiteGold(OBJECT_SELF);
    if (nVesper >= 3 || nStaff >= 3 || nDruid >= 3) { nCasterLvl = GetEffectiveCasterLevel(OBJECT_SELF); }
    if (nVesper == 1|| nVesper == 4 || nStaff == 1 || nStaff == 4 || nDruid == 1 || nDruid == 4){ nDice = 10; }

    int nSpellCraft=GetSkillRank(SKILL_SPELLCRAFT, OBJECT_SELF);
    int nSpellBonus=nSpellCraft/5;
    int nModLevel = nCasterLvl + nSpellBonus;

    int nPenetr = nCasterLvl + SPGetPenetr();

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        // This where the previous restriction on caster level went - no limit on Altharia.
        //int nCasterLevel= CasterLvl;
        //Limit caster level
        //if (nCasterLvl > 20)
        //{
        //     nCasterLevel = 20;
        // }

        // Make a faction check
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = PRCGetRandomDelay(1.0, 2.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));
            //Make an SR check
            if ( ! PRCDoResistSpell(OBJECT_SELF, oTarget,nPenetr, 1.0))
            {
                //Check if the target is an undead
                if (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    //Roll damage and save
                   //nDamage = d6(nCasterLevel);
                    nDamage = (Random(nDice) + 1)*nModLevel + 6*nModLevel;    // Modified damage - WK
                    nMax = nDice + 6;
                }
                else
                {
                    //Roll damage and save
                    //nDamage = d6(3);
                    nDamage = (Random(nDice) + 1)*nModLevel + 2*nModLevel;    // Modified damage - WK
                    nOrgDam = nDamage;
                    //nMax = 6;
                    nMax = 2+nDice;
                    //nCasterLevel = 3;
                    //Get the adjusted damage due to Reflex Save, Evasion or Improved Evasion
                }

                //Do metamagic checks
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                    //nDamage = nMax * nCasterLevel;
                    nDamage = nMax * nModLevel; // Modified damage - WK
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                    nDamage = nDamage + (nDamage/2);
                }

                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);

                //Check that a reflex save was made.
                if(PRCMySavingThrow(SAVING_THROW_REFLEX, oTarget, (nDC), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 1.0) == 0)
                {
                    DelayCommand(1.0, SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength),TRUE,-1,nCasterLvl));
                }
                else
                {
                    nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, 0, SAVING_THROW_TYPE_DIVINE);
                }
                //Set damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_DIVINE);
                if(nDamage > 0)
                {
                    //Apply the damage effect and VFX impact
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    PRCBonusDamage(oTarget);
                }
            }
        }
        //Get the next target in the spell area
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the integer used to hold the spells spell school
}
