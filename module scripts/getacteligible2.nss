#include "wk_tools"

int StartingConditional()
{
    int iResult = FALSE;
    object oPC = GetPCSpeaker();
    string sTag = GetLocalString(oPC,"actitem");
    if (GetHitDice(oPC)>=25)
    {
        iResult = GetIsEligible(oPC,sTag);
    }

    return iResult;
}
