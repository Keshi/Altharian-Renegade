#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("mc_minocstore");

    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());

    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);

}
