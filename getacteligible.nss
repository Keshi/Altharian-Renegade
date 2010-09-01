#include "wk_tools"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sTag = GetLocalString(oPC,"actitem");
    int iResult = GetIsEligible(oPC,sTag);

    return iResult;
}
