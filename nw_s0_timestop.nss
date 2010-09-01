//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
All persons in the Area are frozen in time
except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

// Place the following variable on an area to disable timestop in that area.
// NAME : TIMESTOP_DISABLED TYPE : Int VALUE : 1
// If set to zero, the duration will default to 1 + 1d4 rounds. Otherwise, the
// duration will be the number of seconds the variable is changed to const int
// TIME_STOP_OVERRIDE_DURATION = 0;
// ex. const int TIME_STOP_OVERRIDE_DURATION = 9; Timestop lasts 9 seconds.

#include "x2_inc_spellhook"

void Timestop(object oCaster)
{
object oArea = GetArea(oCaster);
effect eParalyze = EffectCutsceneParalyze();
object oTarget = GetFirstObjectInArea(oArea);
object oImmune = GetItemPossessedBy(oTarget,"antirssextant");
while (GetIsObjectValid(oTarget))
    {
    if (GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
        if (GetIsDM(oTarget) == FALSE)
            {
            if (oTarget != oCaster)
                {
                if (!GetIsObjectValid(oImmune))
                    {
                    FloatingTextStringOnCreature("Time Stopped", oTarget, FALSE);
                    ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eParalyze, oTarget, 9.0);
                    }
                }
            }
        }
    oTarget = GetNextObjectInArea(oArea);
    }
}

void TimestopCheck(object oCaster, int nDuration)
{
if (nDuration == 0)
    {
    return;
    }
nDuration = nDuration - 1;
object oArea = GetArea(oCaster);
location lCaster = GetLocation(oCaster);
effect eParalyze = EffectCutsceneParalyze();
object oTarget = GetFirstObjectInArea(oArea);
while (GetIsObjectValid(oTarget))
    {
    if (GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
        if (GetIsDM(oTarget) == FALSE)
            {
            if (oTarget != oCaster)
                {
                effect eEffect = GetFirstEffect(oTarget);
                while (GetIsEffectValid(eEffect))
                    {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE)
                        {
                        SetLocalInt(oTarget, "TIME_STOPPED", 1);
                        }
                    eEffect = GetNextEffect(oTarget);
                    }
                if (GetLocalInt(oTarget, "TIME_STOPPED") == 0)
                    {
                    FloatingTextStringOnCreature("Time Stopped", oTarget, FALSE);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oTarget, IntToFloat(nDuration));
                    }
                DeleteLocalInt(oTarget, "TIME_STOPPED");
                }
            }
        }
        oTarget = GetNextObjectInArea(oArea);
    }
DelayCommand(1.0, TimestopCheck(oCaster, nDuration));
}

void main()
{
/* Spellcast Hook Code
Added 2003-06-20 by Georg
If you want to make changes to all spells,
check x2_inc_spellhook.nss to find out more */

if (!X2PreSpellCastCode()) {return;}
// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
// End of Spell Cast Hook
if (GetLocalInt(GetArea(OBJECT_SELF), "TIMESTOP_DISABLED") == 1)
    {
    FloatingTextStringOnCreature("Timestop is not permitted in this area", OBJECT_SELF, FALSE);
    return;
    }
//Declare major variables
int nCheck = GetLocalInt(OBJECT_SELF,"TIMESTOP_DISABLED");
if (nCheck == 1 & GetIsPC(OBJECT_SELF))
  {
    SendMessageToPC(OBJECT_SELF,"You have recently ridden the currents of Time, and must wait until the distortions have settled.");
    return;
  }
location lTarget = GetSpellTargetLocation();
effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
int nDuration = 1 + d3(1);
float fDuration = RoundsToSeconds(nDuration);
int nSeconds = FloatToInt(fDuration);

//Fire cast spell at event for the specified target
SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
Timestop(OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"TIMESTOP_DISABLED",1);
DelayCommand(240.0,SetLocalInt(OBJECT_SELF,"TIMESTOP_DISABLED",0));
DelayCommand(1.0, TimestopCheck(OBJECT_SELF, nSeconds));
}
