int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_DEXTERITY, TRUE) < 40;
    return iResult;
}
