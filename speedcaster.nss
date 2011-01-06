//Script Name: speedcaster
//////////////////////////////////////////
//Created By: Genisys (Guile)
//Created On: 9/4/08
/////////////////////////////////////////
/*
  This is a tagbase item script for the
  item tagnamed "speedcaster", it will
  run through all of the user's memorized
  spells and have them buff themself very
  fast!  This is the item, because you
  do not have to keep charging the item!
*/
////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    object oPC;         //The caster
    object oItem;       //This item
    object oTarget;     //The Target of the Item

    int nResult = X2_EXECUTE_SCRIPT_CONTINUE;

 //this handles "use" or activation of item.
 if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
 {
   oItem = GetItemActivated();
   oPC = GetItemActivator();
   oTarget = GetItemActivatedTarget();

   //Make the PC cast all their buff spells they can cast..
   ExecuteScript("fastbuff_pc", oPC);
 }

 //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
