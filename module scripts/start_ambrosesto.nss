//::///////////////////////////////////////////////
//:: FileName start_ambrosesto
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/25/2003 11:07:52 AM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()

{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("ambrosestore");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
