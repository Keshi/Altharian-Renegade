int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_WISDOM, TRUE) + GetLocalInt(GetPCSpeaker(), "wish_inc_wis") < 50;
    return iResult;
}
