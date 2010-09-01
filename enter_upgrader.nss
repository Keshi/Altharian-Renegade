/////::///////////////////////////////////////////
/////:: enter_upgrader
/////:: Purpose is to swap items out for new versions
/////:: Written by Winterknight for Altharia 8/2/07
/////::///////////////////////////////////////////

void DoSwapOut(object oPC, string sTag)
{
  object oItem = GetItemPossessedBy(oPC,sTag);
  if(oItem != OBJECT_INVALID)
  {
    string sName = GetName(oItem);
    DestroyObject(oItem,0.1);
    string sLeft = GetStringLeft(sTag,9);
    if (sLeft == "nodestone")
    {
      int nLong = GetStringLength(sTag);
      string sNew = GetSubString(sTag,9,nLong-9);
      sTag = "truestone"+sNew;
    }
    CreateItemOnObject(sTag,oPC,1);
    SendMessageToPC(oPC,"Swapped item: "+sName);
  }
}

void main()
{
  object oPC = GetPCSpeaker();
  string sTag,sName;
  sTag == "dg_craftguide1";
  DoSwapOut(oPC,sTag);
  sTag == "dg_craftguide2";
  DoSwapOut(oPC,sTag);
  sTag == "craftersbook";
  DoSwapOut(oPC,sTag);
  sTag == "sk_collectguide";
  DoSwapOut(oPC,sTag);
  sTag == "guardiantext";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss01";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss02";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss03";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss04";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss05";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss06";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss07";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss08";
  DoSwapOut(oPC,sTag);
  sTag == "bookoftheabyss09";
  DoSwapOut(oPC,sTag);
  sTag == "nodestone_abyss";
  DoSwapOut(oPC,sTag);

  object oItem = GetItemPossessedBy(oPC,sTag);
  if (oItem != OBJECT_INVALID)
  {
      DestroyObject(oItem,0.1);
      CreateItemOnObject("invsweeper",oPC,1);
      SendMessageToPC(oPC,"Swapped magic eater for inventory sweeper.");
  }

}
