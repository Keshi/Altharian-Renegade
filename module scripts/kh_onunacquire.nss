// if the player drops a PLOT item, put it back in their inventory
// the plot items ResRef MUST BE the same as its TAG

void main()
{
  object oDropped= GetModuleItemLost();
  string sTag= GetTag(oDropped);
  object oPC= GetModuleItemLostBy();

     //flag any dropped or sold item so the store can kill it
     // on the minute it is to be destroyed

  int iMinute = GetLocalInt (GetObjectByTag("Roomwith7DoorsSouth"),"minute");
  SetLocalInt(oDropped, "PCItem", iMinute+30);

     /**************************************************
     * Jamos' no drop code uses copy object which
     * is instant unlike the old no drop code which
     * if dropped on ground could cause errors with logging
     * out immediatly after.
     **************************************************/
    // check to see if the item is PLOT
  if (GetPlotFlag (oDropped))
    {
      // the first drop was allowed because oLost by was BLANk
      // but not OBJECT_INVALID
     object oLostBy = oPC;
     SetLocalObject(oDropped, "ND_OWNER",oPC);

     if (GetIsPC(oLostBy))
       {
        string sItemName = GetName(oDropped);
        object oPossessor = GetItemPossessor(oDropped);
        switch (GetObjectType(oPossessor))
          {

           case OBJECT_TYPE_CREATURE:
             break;  /* no action, PC will give it back in OnAcquireItem */

           case OBJECT_TYPE_STORE:
              //Tried to sell to a merchant
             SendMessageToPC(oLostBy, "The "+ sItemName + " cannot be dropped traded or sold.");
             CopyObject(oDropped, GetLocation(oLostBy), oLostBy);
             DestroyObject(oDropped);
             break;


           case OBJECT_TYPE_PLACEABLE:
              //Tried to place into a container
             SendMessageToPC(oLostBy, "The "+ sItemName + " cannot be dropped traded or sold.");
             CopyObject(oDropped, GetLocation(oLostBy), oLostBy);
             DestroyObject(oDropped);
             break;

           default:
              //Tried to dropp on the ground
             SendMessageToPC(oLostBy, "The "+ sItemName + " cannot be dropped traded or sold.");
             CopyObject(oDropped, GetLocation(oLostBy), oLostBy);
             DestroyObject(oDropped);
          }  //switch end

       }  // if GetIsPC() end

    }  // plotflag end

} //main end

