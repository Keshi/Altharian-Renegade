//::///////////////////////////////////////////////
//:: Isaacs Greater Missile Storm
//:: x0_s0_MissStorm2
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 Up to 20 missiles, each doing 3d6 damage to each
 target in area.
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

    int nDice = 2;
    int nMissiles = 20;
    int nStaff = GetMageStaff(OBJECT_SELF);
    if (nStaff == 1)  // Staff of Destruction
        {
          nDice = 3;
        }

    if (nStaff == 4)    // Avanar, boost for having combined
        {
          nDice = 3;
          int nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
          if (nLevel > 60) nMissiles = 30;
          else if (nLevel < 40) nMissiles = 20;
          else nMissiles = nLevel/2;
        }


    DoMissileStorm(nDice, nMissiles, SPELL_ISAACS_GREATER_MISSILE_STORM);
}


