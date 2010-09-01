//::////////////////////////////////////////////////////////////////////////////
//:: Sack countdown script - HB
//:: Experimental - may cause lag

void TrashObject(object oObject)
{
    //debug(GetTag(oObject) + " is in trashobject");
    if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE) {
        object oItem = GetFirstItemInInventory(oObject);
        while (GetIsObjectValid(oItem))
        {
            //debug(GetTag(oItem) + " is in trashobject");
            TrashObject(oItem);
            oItem = GetNextItemInInventory(oObject);
        }
    }
    //else
        //debug(GetTag(oObject) + " failed to pass as inventory type placeable is getting destroyed");
    AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject(oObject);
}

void main()
{
  int nCount = GetLocalInt(OBJECT_SELF,"countdown");
  if (nCount > 0)
  {
    object oInv = GetFirstItemInInventory(OBJECT_SELF);
    if (oInv == OBJECT_INVALID) nCount = 0;
    else if (oInv != OBJECT_INVALID) nCount = nCount - 1;
    SetLocalInt(OBJECT_SELF,"countdown",nCount);
  }
  if (nCount <= 0) TrashObject (OBJECT_SELF);
}
