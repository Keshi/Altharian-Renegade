#include "wk_tools"

int StartingConditional()
{
    int iResult = FALSE;
    string sTag = GetTag(OBJECT_SELF);
    object oPC = GetPCSpeaker();
    if (GetHitDice(oPC)>=30)
    {
        iResult = GetIsEligible(oPC,sTag);
    }

    return iResult;
}
