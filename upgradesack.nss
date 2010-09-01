//::///////////////////////////////////////////////
//:: FileName give_sackofdust
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/27/2005 1:03:12 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some XP
    int nSack = GetCampaignInt("Character","sackofdust",GetPCSpeaker());
    // Give the speaker the items
    nSack++;
    SetCampaignInt("Character","sackofdust",nSack,GetPCSpeaker());
    DestroyObject(OBJECT_SELF, 1.0);
    int nRand = d6(1);
    string sTag = "WP_refractedlight"+IntToString(nRand);
    location lSpawn = GetLocation(GetWaypointByTag(sTag));
    CreateObject(OBJECT_TYPE_PLACEABLE,"refractedlight",lSpawn,FALSE);

}
