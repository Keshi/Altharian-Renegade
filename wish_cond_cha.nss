int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_CHARISMA, TRUE) < 40;
    return iResult;
}
