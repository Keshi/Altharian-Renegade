
#include "wk_inc_forge"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetHasCollectorCost(oPC)) return FALSE;

    return TRUE;
}
