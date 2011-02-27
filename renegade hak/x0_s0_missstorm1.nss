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

//:: altered by mr_bumpkin Dec 4, 2003 for prc stuff
//Modified for altharia

#include "spinc_bolt"
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
    //altharian mods
    int nDice = 1;
    int nMissiles = 10;
    int nStaff = GetMageStaff(OBJECT_SELF);
    if (nStaff == 1)  // Staff of Destruction
        {
          nDice = 2;
        }

    if (nStaff == 4)    // Avanar, boost for having combined
        {
          nDice = 3;
          int nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
          if (nLevel > 40) nMissiles = 15;
          if (nLevel > 60) nMissiles = 20;
          else if (nLevel < 40) nMissiles = 10;
          else nMissiles = nLevel/4;
        }
       //end altharian stuff

    PRCDoMissileStorm(nDice, nMissiles, SPELL_ISAACS_GREATER_MISSILE_STORM);


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school
}

