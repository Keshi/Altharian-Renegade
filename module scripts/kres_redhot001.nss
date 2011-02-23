void main()
{
  // get the first item in inventory
  object oInside = GetFirstItemInInventory();
  // and if there isn't one
  if (!GetIsObjectValid(oInside))
  {
    // create the gold piece item with a stack of 100
     SetLocked(OBJECT_SELF, TRUE);
     CreateItemOnObject("kres_secret_key", OBJECT_SELF, 1);
  }
}

