int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_WISDOM, TRUE) < 40;
    return iResult;
}
