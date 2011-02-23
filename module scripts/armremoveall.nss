//::///////////////////////////////////////////////
//:: armremoveall
//:: Written for Altharia by Winterknight
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC,"MODIFY_ITEM");
    if (oItem != OBJECT_INVALID)
      {
        int iValue = GetGoldPieceValue(oItem);
        itemproperty ip = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(ip))
          {
            RemoveItemProperty(oItem, ip);
            SendMessageToPC(oPC,"Removed a Property");
            ip = GetNextItemProperty(oItem);
          }
        GiveGoldToCreature(oPC, iValue);
      }

}
