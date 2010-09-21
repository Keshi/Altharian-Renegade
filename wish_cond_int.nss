int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE, TRUE) < 40;
    return iResult;
}
