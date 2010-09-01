//::///////////////////////////////////////////////
//:: Dirge: Heartbeat
//:: x0_s0_dirgeHB.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "wk_tools"

void main()
{



    object oTarget;
    int nDam;
    int nHit = Random(3);
    object oCaster = GetAreaOfEffectCreator();
    int nLevel = (GetLevelByClass(CLASS_TYPE_BARD, oCaster)/2);
    int nBard = GetHarmonic(oCaster);
    if (nBard == 2 || nBard == 4)
      {
        int nBLev = GetLevelByClass(CLASS_TYPE_BARD, oCaster);
        nLevel = GetEffectiveLevel(oCaster);
        if (nLevel > 40) nBLev = nBLev * nLevel / 40;
        nLevel = nBLev;
      }
    nDam = Random(nLevel) + Random(nLevel)/2;
    effect eDam = EffectDamage(nDam,DAMAGE_TYPE_SONIC,DAMAGE_POWER_NORMAL);
    //Start cycling through the AOE Object for viable targets including doors and placable objects.
    oTarget = GetFirstInPersistentObject(OBJECT_SELF);
    while(GetIsObjectValid(oTarget) & GetIsEnemy(oTarget,oCaster))
    {
     DoDirgeEffect(oTarget);
     if (nHit == 1) DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        //Get next target.
    oTarget = GetNextInPersistentObject(OBJECT_SELF);
    }
}


