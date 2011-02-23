//::///////////////////////////////////////////////
//:: NW_ALL_FEEDBACK2.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Return true if player has activated a Word of
  Recall before.  CHAPTER 1 and CHAPTER1e
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult = FALSE;
    {
        iResult = GetLocalInt(GetPCSpeaker(), "iHasRecalled")>0;
    }
    return iResult;
}

