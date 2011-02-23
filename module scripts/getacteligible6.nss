#include "wk_tools"

int StartingConditional()
{
    int iResult = FALSE;
    object oPC = GetPCSpeaker();
    string sTag = GetLocalString(oPC,"actitem");

    if (GetEffectiveLevel(oPC)==100)
    {
        iResult = GetIsEligible(oPC,sTag);
    }
    return iResult;
}
