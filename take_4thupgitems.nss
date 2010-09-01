//::///////////////////////////////////////////////
//:: FileName take_4thupgitems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 10:27:53 PM
//:://////////////////////////////////////////////
void main()
{

  object oPC = GetPCSpeaker();
  int nColl = GetCampaignInt("Collector","CollectorTally",oPC);
  int nMith = GetCampaignInt("12Dark2","mithril",oPC);
  nColl = nColl - 100;
  nMith = nMith - 500;
  SetCampaignInt("Collector","CollectorTally",nColl,oPC);
  SetCampaignInt("12Dark2","mithril",nMith,oPC);

}
