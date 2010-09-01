#include "wk_tools"

int StartingConditional()
{
    int iResult = FALSE;
    string sTag = GetTag(OBJECT_SELF);
    object oPC = GetPCSpeaker();
    if (GetEffectiveLevel(oPC)>=70)
    {
        iResult = GetIsEligible(oPC,sTag);
    }
    return iResult;
}
