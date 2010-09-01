/////:://///////////////////////////////////////////////////////////////////////
/////:: Guild Ring Issue Script - standard format
/////:: Written by Winterknight for Altharia - 11/2/05
/////:: (Modify this for each version of the ring - this one is Mercenary guild.)
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oRing;
    int iCount;
    int nRing;
    string sGuild = "t12d";
    string sRing = sGuild+"_ring_0";
    for (iCount = 1; iCount < 6; iCount++)        // Loop to destroy all versions of the ring in inventory
        {
            string sInc = IntToString(iCount);
            string sOldRing = sRing+sInc;
            oRing = GetItemPossessedBy(oPC,sOldRing);
            if (GetIsObjectValid(oRing)){DestroyObject(oRing);}
        }
    int nLevel = GetHitDice(oPC);
    if (nLevel == 40){nRing = 5;}
    if (nLevel < 40 && nLevel >= 30){nRing = 4;}
    if (nLevel < 30 && nLevel >= 20){nRing = 3;}
    if (nLevel < 20 && nLevel >= 10){nRing = 2;}
    if (nLevel < 10){nRing = 1;}
    string sNewRing = sRing + IntToString(nRing);
    CreateItemOnObject(sNewRing,oPC,1);
    SetCampaignString("Character","guild",sGuild,oPC);
}
