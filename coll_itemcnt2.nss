//::///////////////////////////////////////////////
//:: FileName coll_itemcnt1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/21/2006 11:06:33 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if((GetLocalInt(GetPCSpeaker(), "CurrentItemCount") >= 2))
        return TRUE;

    return FALSE;
}
