//::///////////////////////////////////////////////
//:: Dragon Breath for Wyrmling Shape
//:: x2_s1_wyrmbreath
//:: Copyright (c) 2003Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the power of the dragon breath
    used by a player polymorphed into wyrmling
    shape

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: June, 17, 2003
//:://////////////////////////////////////////////
/*
-- Modified by Iznoghoud January 13 2004
Made a fix for the way the damage is calculated.

- Before, it would determine a number of dice and die type (d4, d6, d8, d10), throw
that die one time, and then multiply that number with the number of dice.
Also, every target got the same amount of damage.

- Now, it determines a number of dice N and die type (d4, d6, d8, d10), throws that
die N times, and adds up the results.
This results in the damage being averaged out like all other spells, instead of
going into the low or high extremes so often. Also, every target can get a
different amount of damage, just like with other spells.
*/
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_shifter"

void main()
{

    //--------------------------------------------------------------------------
    // Set up variables
    //--------------------------------------------------------------------------
    int nType = GetSpellId();
    int nDamageType;
    int nDamageDie;
    int nVfx;
    int nSave;
    int nSpell;
    int nDice;


    //--------------------------------------------------------------------------
    // Decide on breath weapon type, vfx based on spell id
    //--------------------------------------------------------------------------
    switch (nType)
    {
        case 663: //white
            nDamageDie  = 4;
            nDamageType = DAMAGE_TYPE_COLD;
            nVfx        = VFX_IMP_FROST_S;
            nSave       = SAVING_THROW_TYPE_COLD;
            nSpell      = SPELLABILITY_DRAGON_BREATH_COLD;
            nDice       = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF) /2)+1;
            break;

        case 664: //black
            nDamageDie  = 4;
            nDamageType = DAMAGE_TYPE_ACID;
            nVfx        = VFX_IMP_ACID_S;
            nSave       = SAVING_THROW_TYPE_ACID;
            nSpell      = SPELLABILITY_DRAGON_BREATH_ACID;
            nDice       = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF) /2)+1;
            break;

        case 665: //red
            nDamageDie   = 10;
            nDamageType  = DAMAGE_TYPE_FIRE;
            nVfx         = VFX_IMP_FLAME_M;
            nSave        = SAVING_THROW_TYPE_FIRE;
            nSpell       = SPELLABILITY_DRAGON_BREATH_FIRE;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF) /3)+1;
            break;

        case 666: //green
            nDamageDie   = 6;
            nDamageType  = DAMAGE_TYPE_ACID;
            nVfx         = VFX_IMP_ACID_S;
            nSave        = SAVING_THROW_TYPE_ACID;
            nSpell       = SPELLABILITY_DRAGON_BREATH_GAS;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF) /2)+1;
            break;

        case 667: //blue
            nDamageDie   = 8;
            nDamageType  = DAMAGE_TYPE_ELECTRICAL;
            nVfx         = VFX_IMP_LIGHTNING_S;
            nSave        = SAVING_THROW_TYPE_ELECTRICITY;
            nSpell       = SPELLABILITY_DRAGON_BREATH_LIGHTNING;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF) /3)+1;
            break;

    }

    //--------------------------------------------------------------------------
    // Calculate Save DC based on shifter level
    //--------------------------------------------------------------------------
    int  nDC  = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_NORMAL);

    //--------------------------------------------------------------------------
    // Calculate Damage
    //--------------------------------------------------------------------------


    int nDamage = 0;
    int i;
    int nDamStrike;
    float fDelay;
    object oTarget;
    effect eVis, eBreath;

    //--------------------------------------------------------------------------
    //Loop through all targets and do damage
    //--------------------------------------------------------------------------
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            // Calculate damage for this target
            nDamage = 0;
            for (i = 0; i < nDice; i++) // Roll the damage die nDice times and add up the damage.
                nDamage += (Random(nDamageDie)+1);

            nDamStrike =  GetReflexAdjustedDamage(nDamage, oTarget, nDC);
            if (nDamStrike > 0)
            {
                eBreath = EffectDamage(nDamStrike, nDamageType);
                eVis = EffectVisualEffect(nVfx);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreath, oTarget));
             }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    }
}
