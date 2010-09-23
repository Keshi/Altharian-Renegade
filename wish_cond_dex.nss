int StartingConditional()
{
    int iResult;

    iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_DEXTERITY, TRUE) + GetLocalInt(GetPCSpeaker(), "wish_inc_dex") < 40;
    return iResult;
}
