/////:://///////////////////////////////////////////////////////////////////////
/////:: Respawn inventory of object - change variables as needed
/////:: Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////
object oChest;
string sItemRef;

void DelayedInventoryCleaner(object oChest)
{
    object oDie = GetFirstItemInInventory (oChest);
    while (GetIsObjectValid(oDie))
        {
            DestroyObject(oDie, 0.5);
            oDie = GetNextItemInInventory(oChest);
        }
}

void DelayedCreator(string sItemRef, object oChest)
{
    CreateItemOnObject(sItemRef, oChest, 1);
}

void main()
{
    oChest=OBJECT_SELF;
    sItemRef = "bararchonring";
    DelayCommand(600.0,DelayedInventoryCleaner(oChest));
    DelayCommand(600.2,DelayedCreator(sItemRef, oChest));
    sItemRef = "halshorsreliquar";
    DelayCommand(600.4,DelayedCreator(sItemRef, oChest));
}
