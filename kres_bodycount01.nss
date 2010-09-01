void main()
{
  // get the first item in inventory
  object oInside = GetFirstItemInInventory();
  // and if there isn't one
  if (!GetIsObjectValid(oInside))
  {
      CreateItemOnObject("kresguidebook", OBJECT_SELF, 1);
  }
}

