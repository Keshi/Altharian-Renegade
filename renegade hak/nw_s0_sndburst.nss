//::///////////////////////////////////////////////
//:: [Sound Burst]
//:: [NW_S0_SndBurst.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Does 1d8 damage to all creatures in a 10ft
//:: radius.  Will save or the creature is stunned
//:: for 1 round.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Z, Oct. 2003

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
        return;
    }
    // End of Spell Cast Hook


    //Declare major variables
    object oTarget;
    float fSize = RADIUS_SIZE_MEDIUM;
    object oCaster = OBJECT_SELF;
    //int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nMod = 0;
    int nVesper = GetVesper(oCaster);
    int nBard = GetHarmonic(oCaster);
    int nLevel = PRCGetCasterLevel(oCaster);
    if (nVesper >= 3 || nBard == 4)
      {
        nLevel = GetEffectiveCasterLevel(oCaster);
        nMod = nLevel/10;
        fSize = RADIUS_SIZE_COLOSSAL;
      }
    if (nBard == 2)
      {
        nMod = nLevel/10;
        fSize = RADIUS_SIZE_COLOSSAL;
      }

    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_SONIC);

    int nCasterLevel = nLevel;
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    effect eStun = EffectStunned();
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eStun, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eDam;
    int nPenetr = nCasterLevel + SPGetPenetr();

    location lLoc = GetSpellTargetLocation();

    //Apply the FNF to the spell location
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, lLoc);
    //Get the first target in the spell area
    oTarget = MyFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SOUND_BURST));
            //Make a SR check
            if(!PRCDoResistSpell(OBJECT_SELF, oTarget,nPenetr))
            {
                int nDC = (PRCGetSaveDC(oTarget,OBJECT_SELF));
                //Roll damage
                //nDamage = d8();
                nDamage = d8(nMod * 2);
                //Make a Will roll to avoid being stunned
                if(!/*Will Save*/ PRCMySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
                {
                    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2),TRUE,-1,nLevel);
                }
                //Make meta magic checks
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                     nDamage = 8 * nMod * 2;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                    nDamage = nDamage + (nDamage/2);
                }
                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                //Set the damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, EleDmg);
                //Apply the VFX impact and damage effect
                SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
                DelayCommand(0.01,SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget));
            }
        }
        //Get the next target in the spell area
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, fSize, lLoc);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the integer used to hold the spells spell school
}

