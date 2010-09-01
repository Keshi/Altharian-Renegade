//::///////////////////////////////////////////////
//:: Isaacs Lesser Missile Storm
//:: x0_s0_MissStorm1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 Up to 10 missiles, each doing 1d6 damage to all
 targets in area.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 31, 2002
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

   //SpawnScriptDebugger();                         503
    int nDice = 1;
    int nMissiles = 15;
    int nStaff = GetMageStaff(OBJECT_SELF);
    if (nStaff == 2)  // Staff of warrior mage
        {
          nDice = 2;
        }

    if (nStaff == 4)    // Avanar, boost for having combined
        {
          nDice = 2;
          int nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
          if (nLevel > 15) nMissiles = 15 + (nLevel-15)/5;
        }


    DoMissileStorm(nDice, nMissiles, GetSpellId(), 503,VFX_IMP_LIGHTNING_S ,DAMAGE_TYPE_ELECTRICAL, FALSE, TRUE );
}
