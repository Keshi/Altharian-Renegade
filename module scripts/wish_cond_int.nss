int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE, TRUE) +  GetLocalInt(GetPCSpeaker(), "wish_inc_int") < 50;
    return iResult;
}
