int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_CONSTITUTION, TRUE) + GetLocalInt(GetPCSpeaker(), "wish_inc_con") < 50;
    return iResult;
}
