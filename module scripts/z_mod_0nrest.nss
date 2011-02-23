//////////////////////////////////////////////
//:: Name: Zimero's Limited Resting v1.2
//:: FileName: z_mod_onrest
//:://////////////////////////////////////////////
/*
What does it do?
The player must wait x hours between resting.
If the player(or someone else) cancels the rest
the waiting time is proportional to the amount of
time which passed before it was canceled.
For example, with the default setting, if the
player only rests 1/6 of the rest, he/she only has
to wait one hour, before he/she can rest again.

The formula for the resting time used:
0,5X + 10 (seconds) where x is the total level of the player.

How to use:
Assign this script to the onrest event of your module.

Thanks to the NWN Lexicon, it helped me alot!
*/
//:://////////////////////////////////////////////
//:: Created By: Jonas Boberg aka. zimero
//:: Created On: 20021212
//:: Modified On: 20030107
//:://////////////////////////////////////////////

//USER ADJUSTABLE VARIABLES
//the number of hours the players must wait between full rests
int TIMEBETWEENRESTING=0;
//do you want to display the time until next rest in real world minutes?
//(default: game hours)
int REALTIMEMINUTES=0;
//END USER ADJUSTABLE VARIABLES

int CurrentTime();

void main()
{
    //initiate the variables
    object oPC = GetLastPCRested();
    int iCurrentTime, iLastRestTime, iTimeSinceRest, iTimeUntilRest;
    float fTimePenalty;

    switch (GetLastRestEventType())
    {
    case REST_EVENTTYPE_REST_STARTED:
       // SendMessageToAllDMs(GetName(oPC)+ " started rest.");
        //get the current time
        iCurrentTime = CurrentTime();
        //gets the last time the player rested
        iLastRestTime = GetLocalInt(oPC,"REST_HOUR");
        //the time (in hours) since the last rest
        iTimeSinceRest = iCurrentTime-iLastRestTime;

        //stores the second the player begins to rest
        SetLocalInt(oPC, "REST_SECOND", GetTimeSecond());

        //if the player has never rested before or if the
        //necessary time has passed, allow the player to rest
        if (iLastRestTime==0 || iTimeSinceRest >= TIMEBETWEENRESTING)
        {
            SetLocalInt(oPC, "REST_ALLOWED", TRUE);
            SetLocalInt(oPC, "skullcount",0);
            SetLocalInt(oPC, "mercbuffs",0);
            SetLocalInt(oPC, "guild_uses",0);
            SetLocalInt(oPC,"UpgradeTimer",0);
            SetLocalInt(oPC,"VirtueBuff",0);
            string sTag = GetLocalString(oPC,"actitem");
            SetLocalInt(oPC,sTag,0);
        }
        //else display a message and cancel the rest
        else
        {
            SetLocalInt(oPC, "REST_ALLOWED", FALSE);
            //count the time until next rest
            iTimeUntilRest = TIMEBETWEENRESTING-iTimeSinceRest;
            //if the script is configured to display the time in
            //real minutes, do that
            if (REALTIMEMINUTES == 1)
                {
                iTimeUntilRest = FloatToInt(HoursToSeconds(iTimeUntilRest)/60);
                //if there is just one minute to wait, change the message
                //a bit
                if (iTimeUntilRest == 1)
                    {
                    SendMessageToPC(oPC,"You must wait another" +
                                "   minute before you can rest again");
                    }
                else
                    {
                    FloatingTextStringOnCreature("You must wait another "+
                                              IntToString(iTimeUntilRest)+
                               " minutes before you can rest again", oPC);
                    }
                }
            else
                {
                //if there is just one minute to wait, change the message
                //a bit
                if (iTimeUntilRest == 1)
                    {
                    SendMessageToPC(oPC,"You must wait another" +
                                  " game hour before you can rest again");
                    }
                else
                    {
                    SendMessageToPC(oPC,"You must wait another "+
                                              IntToString(iTimeUntilRest)+
                                 " game hours before you can rest again");

                     }

                }
        //cancel the rest
        AssignCommand(oPC,ClearAllActions());
        }
        break;

    case REST_EVENTTYPE_REST_CANCELLED:

        // SendMessageToAllDMs(GetName(oPC)+ " had rest canceled.") ;
        //variable to check that the player was allowed to rest
        if (GetLocalInt(oPC, "REST_ALLOWED") == TRUE)
        {
            //get the current second
            iCurrentTime = GetTimeSecond();
            //get the second the rest beginned
            iLastRestTime = GetLocalInt(oPC, "REST_SECOND");
            //the time (in seconds) the rest lasted
            iTimeSinceRest = iCurrentTime - iLastRestTime;
            //if the time is negative, add 60 to it
            if (iTimeSinceRest<0) iTimeSinceRest+= 60;

            //formula for the time which the player must wait
            //until next rest
           /// fTimePenalty = TIMEBETWEENRESTING*(iTimeSinceRest/(0.5*GetHitDice(oPC)+10));
              fTimePenalty =0.0f;
            //set the variable which controlles when the player may rest again
            SetLocalInt(oPC,"REST_HOUR", CurrentTime()-(TIMEBETWEENRESTING-FloatToInt(fTimePenalty)));
        }
        break;

    case REST_EVENTTYPE_REST_FINISHED:
        //set the variable which controlles when the player may rest again
        SetLocalInt(oPC, "REST_HOUR", CurrentTime());
     //     SendMessageToAllDMs(GetName(oPC)+ " completed rest.");

    }

}

int CurrentTime()
{
//converts current year, month, day and hour to hours
return GetCalendarYear()*8064 + GetCalendarMonth()*672 + GetCalendarDay()*24 + GetTimeHour();
}

