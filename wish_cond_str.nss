int StartingConditional()
{
    int iResult;
    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH, TRUE) < 40;

    return iResult;
}
