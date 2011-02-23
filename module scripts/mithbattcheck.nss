void main()
{
  object oPC = GetLastOpenedBy();
  object oChest = OBJECT_SELF;
  object oEnter = GetInventoryDisturbItem();
  if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED)
    {
      string sTag = GetTag(oEnter);
      if (sTag != "darkmithrilcore")
        {
          ActionGiveItem(oEnter,oPC);
        }
    }
}
