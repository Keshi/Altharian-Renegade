//::///////////////////////////////////////////////
//:: Custom User Defined Event
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: nereng
//:: Created On: 28/04 06
//:://////////////////////////////////////////////
#include "x0_i0_anims"
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == 1001) //HEARTBEAT
    {

    }
    else if(nUser == 1002) // PERCEIVE
    {
        object oPerceive = GetLastPerceived();
        if (GetIsPC(oPerceive) == TRUE)
        {
            DelayCommand(0.2, ExecuteScript("x0_d1_g2_hello", OBJECT_SELF));
            SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT, FALSE);
        }
    }
    else if(nUser == 1004) // ON DIALOGUE
    {
        int iListen = GetListenPatternNumber();
        string sHeard;
        if (iListen = 101)
        {
            object oSpeaker = GetLastSpeaker();
            object oPC = GetNearestCreature (CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, OBJECT_SELF,1,
                                CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            object oWorkbench = GetNearestObjectByTag("N_Workbench");
            object oWP = GetWaypointByTag("APPRENTICE_WP");


            sHeard = GetMatchedSubstring(0);
            if (GetIsPC(oSpeaker) == TRUE)
            {
                if (oWorkbench != OBJECT_INVALID)
                {
                    object oItem = GetFirstItemInInventory(oWorkbench);
                    object oNext = GetNextItemInInventory(oWorkbench);

                    if (oNext != OBJECT_INVALID)
                    {
                        SpeakString("Too many items on the table!");
                        return;
                    }
                    if (oItem != OBJECT_INVALID && sHeard != "")
                    {
                        ActionMoveToObject(oWorkbench, TRUE);
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 3.0);
                        ActionDoCommand(SetName(oItem, sHeard));
                        ActionSpeakString("Finished!");
                        ActionWait(1.0);
                        ActionMoveToObject(oWP, TRUE);
                        SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT, FALSE);
                        return;
                    }
                }
            }
        }
    }
}
