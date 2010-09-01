//::///////////////////////////////////////////////
//:: Quillfire
//:: [x0_s0_quillfire.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fires a cluster of quills at a target. Ranged Attack.
    2d8 + 1 point /2 levels (max 5)

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 17 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 02, 2003

#include "NW_I0_SPELLS"
#include "x0_i0_spells"
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


    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nDice = 6;
    int nDruid = GetWhiteGold(oCaster);
    if (nDruid >= 3)
      {
        nCasterLvl = GetEffectiveCasterLevel(oCaster);
      }
    if (nDruid == 2 || nDruid == 4)
      {
        nDice = 10;
      }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_QUILLFIRE));
        //Apply a single damage hit for each missile instead of as a single mass
        //Make SR Check
        {

                int nMissile = nCasterLvl / 5;

                DoMissileStorm(nDice, nMissile, SPELL_QUILLFIRE, VFX_IMP_MIRV, VFX_IMP_MAGBLUE,DAMAGE_TYPE_MAGICAL,FALSE);

                // * also applies poison damage
                effect ePoison = EffectPoison(POISON_LARGE_SCORPION_VENOM);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoison, oTarget);

        }
    }
}



