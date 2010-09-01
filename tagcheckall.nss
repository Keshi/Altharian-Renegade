void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  string sTag;
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Right Hand Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Left Hand Item: "+sTag);
    }
  oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Chest Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Head Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Amulet Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Glove Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Right ring Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Left ring Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Boot Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Belt Item: "+sTag);
    }

  oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
  if (oItem != OBJECT_INVALID)
    {
      sTag = GetTag(oItem);
      SendMessageToPC (oPC,"Cloak Item: "+sTag);
    }

}
