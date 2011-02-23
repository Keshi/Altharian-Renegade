//::///////////////////////////////////////////////
//:: FileName take_3rdupgitems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 10:39:58 PM
//:://////////////////////////////////////////////
void main()
{

  object oPC = GetPCSpeaker();
  int nColl = GetCampaignInt("Collector","CollectorTally",oPC);
  int nMith = GetCampaignInt("12Dark2","mithril",oPC);
  nColl = nColl - 50;
  nMith = nMith - 200;
  SetCampaignInt("Collector","CollectorTally",nColl,oPC);
  SetCampaignInt("12Dark2","mithril",nMith,oPC);

}
