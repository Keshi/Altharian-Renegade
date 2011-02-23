/////:://///////////////////////////////////////////////////////////////////////
/////:: Holy Avenger Upgrade
/////:: Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyHolyAvenger(), oWeapon);
  int nBlessed = GetCampaignInt("altharia","avengerblessings",oPC);
  nBlessed++;
  SetCampaignInt("altharia","avengerblessings",nBlessed,oPC);

}
