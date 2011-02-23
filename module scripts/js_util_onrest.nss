void main()
{
    object oPlayer = GetLastPCRested();
   int IsTooEarly ;

   if (GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED)
    {
       // If the tooearly flaf is on (1) no message to the DM because resting wa
      // interrupted for a legal reason
      // interrupt rest bug abuse  added by KH on 12-6-02

       IsTooEarly = GetLocalInt(oPlayer,"tooearly");
       if (IsTooEarly==0)
        {
       SendMessageToAllDMs(GetName(oPlayer)+" has terminated resting. Possible rest abuse.");
        }
    }


    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        effect eSleep = EffectVisualEffect(VFX_IMP_SLEEP);

       int iLastHourRest = GetLocalInt(oPlayer, "LastHourRest");
        int iLastDayRest = GetLocalInt(oPlayer, "LastDayRest");
        int iLastYearRest = GetLocalInt(oPlayer, "LastYearRest");
        int iLastMonthRest = GetLocalInt(oPlayer, "LastMonthRest");
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear();
        int iMonth = GetCalendarMonth();
        int iHowLong = 0;
        int iSum = iLastHourRest + iLastDayRest + iLastYearRest + iLastMonthRest;

        if (iLastYearRest != iYear)
            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)
            iDay = iDay + 28;
        if (iDay != iLastDayRest)
            iHour = iHour + 24 * (iDay - iLastDayRest);



        iHowLong = iHour - iLastHourRest;
         //////// rest in game hours     2 minutes = 1 game hour             8  was 8
        if ((iHowLong < 3) && (iSum != 0))  /// rest every 6 minutes
        {
            AssignCommand(oPlayer, ClearAllActions());
            //                                                  8 was 8
            string msg = "You may rest again in " + IntToString(3-iHowLong) + " hours.";
            SendMessageToPC(oPlayer, msg);
                //  SendMessageToAllDMs(GetName(oPlayer)+" is TOO EARLY to rest.........");
                  //SendMessageToAllDMs("Setting tooearly flag.");
                  SetLocalInt(oPlayer, "tooearly",1);

        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oPlayer, 7.0);
            DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oPlayer, 7.0));
        }




    }
    else if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
    {
        SetLocalInt(oPlayer, "LastHourRest", GetTimeHour());
        SetLocalInt(oPlayer, "LastDayRest", GetCalendarDay());
        SetLocalInt(oPlayer, "LastMonthRest", GetCalendarMonth());
        SetLocalInt(oPlayer, "LastYearRest", GetCalendarYear());
        // reset the tooearly flag
        SetLocalInt(oPlayer, "tooearly",0);
    }


}
