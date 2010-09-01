int StartingConditional()
{
    int iResult;
    string sCampaign = "12dark2" ;
    string sVar="mithril" ;
    int iMith= GetCampaignInt(sCampaign,sVar,GetPCSpeaker());
//    return TRUE;
    if (iMith>299) return TRUE;
    return FALSE;


}
