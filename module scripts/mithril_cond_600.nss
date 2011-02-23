int StartingConditional()
{
    int iResult;
    string sCampaign = "12dark2" ;
    string sVar="mithril" ;
    int iMith= GetCampaignInt(sCampaign,sVar,GetPCSpeaker());
    if (iMith>599) return TRUE;
    return FALSE;


}
