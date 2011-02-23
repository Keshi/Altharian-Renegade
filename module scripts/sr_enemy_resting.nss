#include "sr_constants_inc"
void EnemyRest()
{
    object oPC = OBJECT_SELF;
    object oMod = OBJECT_SELF;
    int nCurrHP = GetCurrentHitPoints(oPC);
    int iRestPeriod = 2 + FloatToInt((GetHitDice(oPC) * 0.5) - 0.25);
    if (!RESTON) iRestPeriod=0;

    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    string sRestText = GetName(oPC) + " hasn't waited long enough to rest.";

        //First get the time last rested and the current time.
        int iLastHourRest = GetLocalInt(oMod, ("LastHourRest"));
        int iLastDayRest = GetLocalInt(oMod, ("LastDayRest"));
        int iLastYearRest = GetLocalInt(oMod, ("LastYearRest"));
        int iLastMonthRest = GetLocalInt(oMod, ("LastMonthRest"));
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear();
        int iMonth = GetCalendarMonth();
        int iHowLong = 0;

        if (iLastYearRest != iYear)
            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)
            iDay = iDay + 28;
        if (iDay != iLastDayRest)
            iHour = iHour + 24 * (iDay - iLastDayRest);

        iHowLong = iHour - iLastHourRest;

        if (iHowLong < iRestPeriod)
        {
            AssignCommand(oPC, ClearAllActions());
            FloatingTextStringOnCreature(sRestText, oPC, FALSE);
        } else {
            ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 12.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 6.0);
            DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 6.0));
            SetLocalInt(oMod, "LastHourRest", GetTimeHour());
            SetLocalInt(oMod, "LastDayRest", GetCalendarDay());
            SetLocalInt(oMod, "LastMonthRest", GetCalendarMonth());
            SetLocalInt(oMod, "LastYearRest", GetCalendarYear());
            int iHeal = GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC);
            effect eHeal = EffectHeal(iHeal);
            if (iHeal>0)
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);

        }
}
