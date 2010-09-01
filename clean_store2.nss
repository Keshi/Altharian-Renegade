///////////////////////////////////////////////////////
// clean_store2
// Merchant inventory cleanup script 2.0
// goes in merchant object onOpenStore script handler
//
// written September 30, 2003 by NWC Snake
// copyright 2003 by Neverwinter Consortium
// Permission to use this script is granted as long
// as no changes are made to any portion of the script
//
//////////////////////////////////////////////////////
//
// This script will eliminate items tagged with the
// local integer PCItem
//
// Requires onItemAcquired script that sets PCItem
// to 1 when a PC picks up an item
//
// This version does not allow PC items to persist
// in the merchant inventory. PC items are destroyed
// when the store is first opened
//
// If the store is opened by a conversation, make sure
// you set it to No Interruption to avoid problems
//
//////////////////////////////////////////////////////


void main()
{ // start main

// create object variable for store object (self)
object oStore = OBJECT_SELF;


  object oArea= GetObjectByTag("Roomwith7DoorsSouth");
  int iMinute = GetLocalInt (oArea,"minute") ;


// Get first item in store inventory
object oItem = GetFirstItemInInventory(oStore);

// start while loop, checking for valid inventory items
while(GetIsObjectValid(oItem))
     {
     // read item's PCItem flag
     int nItemFlag = GetLocalInt(oItem, "PCItem");

     // if PCItem flag is non-zero, destroy the item
     if(nItemFlag != 0 &&   iMinute > nItemFlag  )
       {
       DestroyObject(oItem);
       }
       // get next item in store inventory
       oItem = GetNextItemInInventory(oStore);
      } // end while
} // end main
