//::///////////////////////////////////////////////
//:: Firebrand
//:: x0_x0_Firebrand
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// * Fires a flame arrow to every target in a
// * colossal area
// * Each target explodes into a small fireball for
// * 1d6 damage / level (max = 15 levels)
// * Only nLevel targets can be affected
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 29 2002
//:://////////////////////////////////////////////
//:: Last Updated By:
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "wk_tools"

void main()
{

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


    int nDamage =  GetCasterLevel(OBJECT_SELF);
    int nMax = 15;

    int nSave = TRUE;
    int nStaff = GetMageStaff(OBJECT_SELF);
    if (nStaff == 2)  // Staff of Warrior Mage
        {
          nSave = FALSE;
          nMax = 20;
        }

    if (nStaff == 4)    // Avanar, boost for having combined
        {
          nSave = FALSE;
          int nDamage = GetEffectiveCasterLevel(OBJECT_SELF);
          if (nDamage > 15) nMax = (nDamage - 15)/5 + 15;
        }

    if (nDamage > nMax)nDamage = nMax;


    DoMissileStorm(nDamage, nMax, SPELL_FIREBRAND, VFX_IMP_MIRV_FLAME, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE, TRUE, nSave);
}




