int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE, TRUE) +  GetLocalInt(GetPCSpeaker(), "wish_inc_int") < 40;
    return iResult;
}
