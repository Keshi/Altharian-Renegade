#include "wk_tools"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = FALSE;
    string sTag = GetLocalString(oPC,"actitem");

    if (GetHitDice(oPC)>=30)
    {
        iResult = GetIsEligible(oPC,sTag);
    }

    return iResult;
}
