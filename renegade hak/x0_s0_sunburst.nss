//::///////////////////////////////////////////////
//:: Sunburst
//:: X0_S0_Sunburst
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Brilliant globe of heat
// All creatures in the globe are blinded and
// take 6d6 damage
// Undead creatures take 1d6 damage (max 25d6)
// The blindness is permanent unless cast to remove it
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 23 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 14, 2003
//:: Notes: Changed damage to non-undead to 6d6
//:: 2003-10-09: GZ Added Subrace check for vampire special case, bugfix
//altered by joe, should this really be magic dmg type?

//:: altered by mr_bumpkin Dec 4, 2003 for prc stuff
#include "prc_inc_spells"
#include "wk_tools"

#include "prc_add_spell_dc"

float nSize =  RADIUS_SIZE_COLOSSAL;



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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = PRCGetCasterLevel(OBJECT_SELF);
//  Altharian stuff
    int nLevel = PRCGetCasterLevel(oCaster);
    int nDice =6;
    int nNormMax = 6;
    int nVesper = GetVesper(oCaster);
    int nDruid = GetWhiteGold(oCaster);
    int nstaff = GetMageStaff(oCaster);
    if (nDruid >= 3 ||
        nVesper >= 3 ||
        nstaff >= 3 )
      {
        nLevel = GetEffectiveCasterLevel(oCaster);
      }
    if (nDruid == 1  || nDruid == 4||
        nVesper == 1 || nVesper == 4||
        nstaff == 1  || nstaff == 4)
      {
        nDice = 10;
      }
    nCasterLvl = nLevel;
    //end altharia stuff

    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage = 0;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eHitVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eLOS = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //modified for Altharia, no cap on undead to lvl 100, half on others
    if (nCasterLvl > 25)
    {
        //nCasterLvl = 25 + ((nCasterLvl - 25)/1);
        nNormMax = (nCasterLvl/2) + 1;
    }
    int nPenetr = nCasterLvl + SPGetPenetr();

    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLOS, GetSpellTargetLocation());
    int bDoNotDoDamage = FALSE;
    SpeakString(IntToString(nCasterLvl));

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBURST));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            SPApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);

            if (!PRCDoResistSpell(OBJECT_SELF, oTarget,nPenetr, fDelay))
            {
                if (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    //Roll damage for each target
                    nDamage = PRCMaximizeOrEmpower(nDice, nCasterLvl, nMetaMagic);
                }
                else
                {
                    nDamage = PRCMaximizeOrEmpower(nDice, nNormMax, nMetaMagic);
               }
               //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);

                // * if a vampire then destroy it
                if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_MALE || GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_FEMALE || GetStringLowerCase(GetSubRace(oTarget)) == "vampire" )
                {
                    
                    // * if reflex saving throw fails no blindness
                    if (!ReflexSave(oTarget, (nDC), SAVING_THROW_TYPE_SPELL))
                    {
                        effect eDead = PRCEffectDamage(oTarget, GetCurrentHitPoints(oTarget));
                        //SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oTarget);

                        //Apply epicenter explosion on caster
                        SPApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarget);

                        DelayCommand(0.5, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oTarget));
                        bDoNotDoDamage = TRUE;
                    }
                }
                if (bDoNotDoDamage == FALSE)
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, PRCGetSaveDC(oTarget, OBJECT_SELF), SAVING_THROW_TYPE_SPELL);

                // * Do damage
                if ((nDamage > 0) && (bDoNotDoDamage == FALSE))
                {
                    //Set the damage effect
                    eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_MAGICAL);

                    // Apply effects to the currently selected target.
                    DelayCommand(0.01, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    PRCBonusDamage(oTarget);



                        // * if reflex saving throw fails apply blindness
                        if (!ReflexSave(oTarget, PRCGetSaveDC(oTarget, OBJECT_SELF), SAVING_THROW_TYPE_SPELL))
                        {
                            effect eBlindness = EffectBlindness();
                            SPApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlindness, oTarget,0.0f,TRUE,-1,nCasterLvl);
                        }

                } // nDamage > 0
             }

             //-----------------------------------------------------------------
             // GZ: Bugfix, reenable damage for next object
             //-----------------------------------------------------------------
             bDoNotDoDamage = FALSE;
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school

}





