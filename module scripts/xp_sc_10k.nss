int StartingConditional()
{
object oPC = GetPCSpeaker();
string sCDKey = GetPCPublicCDKey( oPC);

if (!(GetCampaignInt( "XP", sCDKey) > 9999)) return FALSE;

return TRUE;
}

