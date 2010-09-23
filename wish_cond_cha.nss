int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_CHARISMA, TRUE) +  GetLocalInt(GetPCSpeaker(), "wish_inc_cha") < 50;
    return iResult;
}
