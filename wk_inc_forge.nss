/////:://///////////////////////////////////////////////////////////////////////
/////:: wk_inc_forge Library Script for forging functions
/////:: Created for Altharia on 2/24/07
/////:://///////////////////////////////////////////////////////////////////////

string GetWeaponItemTemplate (object oToon)
{
  string sWeap = GetLocalString(oToon,"WEAP_STRING");
  string sValue = GetLocalString(oToon,"WEAP_MOD");
  if (sValue != "")
  {
    sWeap = sWeap+sValue;
  }
  return sWeap;
}

int GetWeaponUpgradeCost (object oPC)
{
  int nCost = 0;
  string sWeap = GetLocalString(oPC,"WEAP_STRING");
  if (sWeap == "weap_keen")
    {
      nCost = 100000;
    }
  int sMod = GetLocalInt(oPC,"MAST_MOD");
  if (sWeap == "weap_damage")
    {
      sMod = GetLocalInt(oPC,"WEAP_DAMAGE");
      if (sMod == 5) nCost = 250000;
      if (sMod == 20) nCost = 500000;
      if (sMod == 25) nCost = 1000000;
      if (sMod == 30) nCost = 2000000;
    }
  if (sWeap == "weap_mcrit")
    {
      sMod = GetLocalInt(oPC,"WEAP_DAMAGE");
      if (sMod == 5) nCost = 100000;
      if (sMod == 20) nCost = 250000;
      if (sMod == 25) nCost = 500000;
      if (sMod == 30) nCost = 1000000;
    }
  if (sWeap == "weap_vregen")
    {
      if (sMod == 5) nCost = 1000000;
      if (sMod == 10) nCost = 2000000;
      if (sMod == 15) nCost = 4000000;
      if (sMod == 20) nCost = 10000000;
    }
  if (sWeap == "weap_bonus")
    {
      if (sMod == 4) nCost = 50000;
      if (sMod == 5) nCost = 100000;
      if (sMod == 6) nCost = 250000;
      if (sMod == 7) nCost = 500000;
      if (sMod == 8) nCost = 750000;
      if (sMod == 9) nCost = 1000000;
      if (sMod == 10) nCost = 2000000;
    }
  return nCost;

}

int GetHasCollectorCost (object oPC)
{
  int nCost;
  int nGet;
  nGet = GetCampaignInt("Collector","CollectorTally",oPC);
  nCost = GetLocalInt(oPC,"WEAP_COLLCOST");
  if (nGet >= nCost) return TRUE;
  return FALSE;
}


void TakeWeaponCollectorCost (object oPC)
{
  int nCost= GetLocalInt(oPC,"WEAP_COLLCOST");
  if (nCost == 0) return;
  int nGet;
  nGet = GetCampaignInt("Collector","CollectorTally",oPC);
  nGet = nGet - nCost;
  SetCampaignInt("Collector","CollectorTally",nGet,oPC);

}

void TakeMastCollectorCost (object oPC)
{
  int nCost= GetLocalInt(oPC,"MAST_COLLCOST");
  if (nCost == 0) return;
  int nGet;
  nGet = GetCampaignInt("Collector","CollectorTally",oPC);
  nGet = nGet - nCost;
  SetCampaignInt("Collector","CollectorTally",nGet,oPC);

}

//void main(){}
