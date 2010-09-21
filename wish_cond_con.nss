int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_CONSTITUTION, TRUE) < 40;
    return iResult;
}
