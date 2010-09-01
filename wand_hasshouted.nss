int StartingConditional()
{
    int nCheck = GetLocalInt(GetObjectByTag("AltharClock"),"rankshout");
    if (nCheck == 0) return TRUE;
    return FALSE;
}
