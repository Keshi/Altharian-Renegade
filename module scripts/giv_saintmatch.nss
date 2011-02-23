

void main()
{
  object oPC = GetPCSpeaker();
  string sBless = GetLocalString(oPC,"blessing");
  string sItem = GetLocalString(oPC,"blesitem");
  CreateItemOnObject(sBless,oPC,1);
  if (sItem != "") CreateItemOnObject(sItem,oPC,1);
  if (sItem == "jehonianelixir") CreateItemOnObject(sItem,oPC,9);
  GiveXPToCreature(oPC,1000);
  GiveGoldToCreature(oPC,1000);
}
