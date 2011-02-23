//::///////////////////////////////////////////////
//:: Default On Heartbeat
//:: NW_C2_DEFAULT1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will have people perform default
    animations.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    SetListenPattern(OBJECT_SELF, "**", 20600); //listen to all text
    SetLocalInt(OBJECT_SELF, "hls_Listening", 1); //listen to all text
    SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening
    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF), TRUE);
    while(GetIsObjectValid(oPC))
    {
        if (GetIsPC(oPC) &&
            !GetIsDM(oPC) &&
            GetLocalInt(OBJECT_SELF, "dmfi_Loiter"))
            {
                SpeakString(GetLocalString(OBJECT_SELF, "dmfi_LoiterSay"));
                DestroyObject(OBJECT_SELF);
            }
        oPC = GetNextObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF), TRUE);
    }
}
