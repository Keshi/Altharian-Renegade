/*
    Psionic OnHit.
    This scripts holds all functions used for psionics on hit powers and abilities.

    Stratovarius
*/

// Include Files:
#include "psi_inc_psifunc"
//
#include "psi_inc_pwresist"
#include "prc_inc_combat"


// Swings at the target closest to the one hit
void SweepingStrike(object oCaster, object oTarget);

// Shadow Mind 10th level ability. Manifests Cloud Mind
void MindStab(object oPC, object oTarget);

// ---------------
// BEGIN FUNCTIONS
// ---------------

void SweepingStrike(object oCaster, object oTarget)
{
    int nValidTarget = FALSE;
    location lTarget = GetLocation(oTarget);
    // Use the function to get the closest creature as a target
        object oAreaTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        while(GetIsObjectValid(oAreaTarget) && !nValidTarget && !GetLocalInt(oCaster, "SweepingStrikeDelay"))
        {
            // Don't hit yourself
            // Make sure the target is both next to the one struck and within melee range of the caster
            // Don't hit the one already struck
            if(oAreaTarget != oCaster &&
               GetIsInMeleeRange(oAreaTarget, oCaster) &&
               GetIsInMeleeRange(oAreaTarget, oTarget) &&
               GetIsReactionTypeHostile(oTarget, oCaster) &&
               oAreaTarget != oTarget)
            {
                // Perform the Attack
        effect eVis = EffectVisualEffect(VFX_IMP_STUN);
        object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster);
        PerformAttack(oAreaTarget, oCaster, eVis, 0.0, 0, 0, GetWeaponDamageType(oWeap), "Sweeping Strike Hit", "Sweeping Strike Miss");
        if(DEBUG) DoDebug("psi_onhit: Sweeping Strike Loop Running");
        // End the loop, and prevent the death attack
        SetLocalInt(oCaster, "SweepingStrikeDelay", TRUE);
            DelayCommand(2.0, DeleteLocalInt(oCaster, "SweepingStrikeDelay"));
        nValidTarget = TRUE;
            }

            //Select the next target within the spell shape.
            oAreaTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }// end while - Target loop
}

void MindStab(object oPC, object oTarget)
{
    SetLocalInt(oPC, "ShadowCloudMind", TRUE);
    SetLocalObject(oPC, "PsionicTarget", oTarget);
    int nClass = GetPrimaryPsionicClass(oPC);
    //UsePower(POWER_CLOUD_MIND, nClass);
    // Trying this for now
    ActionCastSpell(POWER_CLOUD_MIND);
    DelayCommand(1.0, DeleteLocalInt(oPC, "ShadowCloudMind"));
    DelayCommand(1.0, DeleteLocalObject(oPC, "PsionicTarget"));
}
