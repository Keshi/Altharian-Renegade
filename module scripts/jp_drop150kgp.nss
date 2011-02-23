/////:://///////////////////////////////////////////////////////////////////////
/////:: jp_drop scripts
/////:: Originals by Jupiter for altharia - drop bag of gold
/////:://///////////////////////////////////////////////////////////////////////
/////:: Modified by Winterknight to work with the autolooter system
/////:: Autolooter system designed and built by Winterknight
/////:: Further modified by Winterknight to work with boss loot system
////////////////////////////////////////////////////////////////////////////////


#include "NW_I0_GENERIC"

void main()
{
    int nObjectType ;
    string strTemplate ;
    object oPC = GetLastKiller();
    int nLoot = GetLocalInt(oPC,"LootShare");
    if (nLoot >= 1)
    {
      int nGold = 150000;
      int nStart = GetLocalInt(oPC,"Bounty");
      if (nStart > 0) nGold = nGold + nStart;
      SetLocalInt(oPC,"Bounty",nGold);
      ExecuteScript("wk_lootshare",OBJECT_SELF);
    }

    else if (nLoot == 0)
    {
      string sItem;
      sItem = "jp_50kgp" ;
      location lDrop = GetLocation( OBJECT_SELF);
      CreateObject(OBJECT_TYPE_ITEM,sItem,lDrop,TRUE);
      CreateObject(OBJECT_TYPE_ITEM,sItem,lDrop,TRUE);
      CreateObject(OBJECT_TYPE_ITEM,sItem,lDrop,TRUE);
    }
    SignalEvent(OBJECT_SELF, EventUserDefined(1007));
}

