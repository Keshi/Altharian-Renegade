//DMFI Universal Wand scripts by hahnsoo
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    DeleteLocalInt(oPC, "Tens");
    int iOffset = GetLocalInt(oPC, "dmfi_univ_offset")+1;
    string sOffset = GetLocalString(oPC, "dmfi_univ_conv");
    SetLocalInt(oPC, "dmfi_univ_offset", iOffset);

    if (sOffset == "afflict" && iOffset==1)
        return TRUE;
    if (sOffset == "pc_emote" && iOffset==2)
        return TRUE;
    if (sOffset == "emote" && iOffset==2)
        return TRUE;
    if (sOffset == "encounter" && iOffset==3)
        return TRUE;
    if (sOffset == "fx" && iOffset==4)
        return TRUE;
    if (sOffset == "music" && iOffset==5)
        return TRUE;
    if (sOffset == "sound" && iOffset==6)
        return TRUE;
    if (sOffset == "xp" && iOffset==7)
        return TRUE;
    if (sOffset == "onering" && iOffset==8)
        return TRUE;
    if (sOffset == "pc_dicebag" && iOffset==9)
    {
        SetLocalInt(oPC, "dmfi_univ_offset", 8);
        return TRUE;
    }
    if (sOffset == "dicebag" && iOffset==10)
    {
        SetLocalInt(oPC, "dmfi_univ_offset", 9);
        return TRUE;
    }
    if (sOffset == "voice" &&
        GetIsObjectValid(GetLocalObject(oPC, "dmfi_univ_target")) &&
        oPC != GetLocalObject(oPC, "dmfi_univ_target") &&
        iOffset==11)
        return TRUE;
    if (sOffset == "voice" &&
        !GetIsObjectValid(GetLocalObject(oPC, "dmfi_univ_target")) &&
        iOffset==12)
        return TRUE;
    if (sOffset == "voice" &&
        GetIsObjectValid(GetLocalObject(oPC, "dmfi_univ_target")) &&
        oPC == GetLocalObject(oPC, "dmfi_univ_target") &&
        iOffset==13)
        return TRUE;
    if (sOffset == "faction" && iOffset==14)
        return TRUE;
    return FALSE;
}
