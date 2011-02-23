int StartingConditional()
{
    int iResult;
    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH, TRUE) + GetLocalInt(GetPCSpeaker(), "wish_inc_str") < 50;

    return iResult;
}
