#include "NW_I0_GENERIC"

void main()
{
    int nObjectType ;
    string strTemplate ;
    object oPC = GetLastKiller();
    int nLoot = GetLocalInt(oPC,"LootShare");
    if (nLoot >= 1)
    {
      int nGold = 25000;
      int nStart = GetLocalInt(oPC,"Bounty");
      if (nStart > 0) nGold = nGold + nStart;
      SetLocalInt(oPC,"Bounty",nGold);
      ExecuteScript("wk_lootshare",OBJECT_SELF);
    }

    else if (nLoot == 0)
    {
      string sItem;
      sItem = "jp_25kgp" ;
      location lDrop = GetLocation( OBJECT_SELF);
      CreateObject(OBJECT_TYPE_ITEM,sItem,lDrop,TRUE);
    }
    SignalEvent(OBJECT_SELF, EventUserDefined(1007));

}
