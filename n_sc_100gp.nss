int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;

    iResult = GetGold(oPC) > 99;
    return iResult;
}
