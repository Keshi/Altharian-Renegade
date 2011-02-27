//::///////////////////////////////////////////////
//:: Name      Longstrider
//:: FileName  sp_longstrdr.nss
//:://////////////////////////////////////////////
/** @file Longstrider
Transmutation
Level: Drd 1, Rgr 1
Components: V, S
Casting Time: 1 standard action
Range: Personal
Target: You
Duration: 1 hour/level

This spell increases your base land speed by 10 feet.

Author:    Tenjac
Created:   8/14/08
*/
//::///MODIFIED BY JOE TO BE USES AS BLINDING SPEED
//::///WHICH IS AN OTHERWISE MISERABLE FAILURE OF A FEAT
//12 HOURS, DOUBLE SPEED

#include "prc_inc_spells"

void main()
{
    if(!X2PreSpellCastCode()) return;

    PRCSetSchool(SPELL_SCHOOL_TRANSMUTATION);

    object oPC = OBJECT_SELF;
    //int nCasterLvl = PRCGetCasterLevel(oPC);
    float fDur = HoursToSeconds(12);
    int nMetaMagic = PRCGetMetaMagicFeat();
    if (nMetaMagic & METAMAGIC_EXTEND)
    {
        fDur = (fDur * 2);
    }

    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectMovementSpeedIncrease(99)), oPC, fDur);

    PRCSetSchool();
}