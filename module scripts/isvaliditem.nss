/////:://///////////////////////////////////////////////////////////////////////
/////:: Check whether the local object is valid
/////:: Modified by Winterknight on 07/16/07
/////:://///////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC,"MAST_MODIFY");
    if (GetIsObjectValid(oItem)) return TRUE;
    return FALSE;
}


