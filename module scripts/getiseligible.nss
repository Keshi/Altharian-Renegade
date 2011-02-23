#include "wk_tools"

int StartingConditional()
{
    string sTag = GetTag(OBJECT_SELF);
    object oPC = GetPCSpeaker();
    int iResult = GetIsEligible(oPC,sTag);

    return iResult;
}
