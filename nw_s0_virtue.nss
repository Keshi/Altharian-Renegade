//::///////////////////////////////////////////////
//:: Virtue
//:: NW_S0_Virtue.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target gains 1 temporary HP
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 6, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "wk_tools"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    if (GetCurrentHitPoints(OBJECT_SELF)<=500) SetLocalInt(OBJECT_SELF,"VirtueBuff",0);
    int nHasIt = GetLocalInt(OBJECT_SELF,"VirtueBuff");
    if (nHasIt>=1)
      {
        SendMessageToPC(OBJECT_SELF,"You already have this enhancement.  Spell Aborted.");
        return;
      }
    int nVesper = GetVesper(OBJECT_SELF);
    int nMod = 1;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    if (nVesper == 1 || nVesper == 4)
      {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nMod = (nLevel/10) +1;
      }

    int nBuff = nMod * nLevel;
    int nDuration = nLevel;

    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eHP = EffectTemporaryHitpoints(nBuff);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHP, eDur);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VIRTUE, FALSE));
    SetLocalInt(OBJECT_SELF,"VirtueBuff",nDuration*10);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

