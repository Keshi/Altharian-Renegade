int StartingConditional()
{
    int iResult;
    string sCampaign = "12dark2" ;
    string sVar="mithril" ;
    int iMith= GetCampaignInt(sCampaign,sVar,GetPCSpeaker());
    if (iMith>399) return TRUE;
    return FALSE;


}
