//::///////////////////////////////////////////////
//:: FileName take_2ndupgitems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 10:52:38 PM
//:://////////////////////////////////////////////
void main()
{

  object oPC = GetPCSpeaker();
  int nColl = GetCampaignInt("Collector","CollectorTally",oPC);
  int nMith = GetCampaignInt("12Dark2","mithril",oPC);
  nColl = nColl - 25;
  nMith = nMith - 100;
  SetCampaignInt("Collector","CollectorTally",nColl,oPC);
  SetCampaignInt("12Dark2","mithril",nMith,oPC);

}
