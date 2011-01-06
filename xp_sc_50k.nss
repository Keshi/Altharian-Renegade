int StartingConditional()
{
object oPC = GetPCSpeaker();
string sCDKey = GetPCPublicCDKey( oPC);

if (!(GetCampaignInt( "XP", sCDKey) > 50000)) return FALSE;

return TRUE;
}

